stack = {}

function getPilha(id)
	if(stack[id] == nil) then
		stack[id] = {}
		stack[id].n = 1
	end

	return stack[id]
end

function printPilha(id)
	local pilha = getPilha(id)

	local str = ''
	for i=1,pilha.n-1 do
		str = str .. pilha[i] .. '\n'
	end

	return str
end

function popPilha(id)
	local pilha = getPilha(id)

	if(pilha.n>1) then
		pilha.n = pilha.n - 1
	end
end

function popNPilha(pilha,n) --to clean unused values from memory
	if(n>0) then
		for i=1,n do
			pilha[pilha.n] = nil
			pilha.n = pilha.n - 1
		end
	end
end

function clearPilha(id)
	local pilha = getPilha(id)
	pilha.n = 1
end

function rpn(id,msg)
	local pilha = getPilha(id)

	local lista = criaLista(msg)

	for i = 1,#lista do

		for j=1,string.len(lista[i]) do
                	if(string.sub(lista[i],j,j) == ',') then
                        	local temp = string.sub(lista[i],1,j-1) .. '.' .. string.sub(lista[i],j+1)
                                lista[i] = temp
                	end
		end


		if(tonumber(lista[i])~=nil) then
			lista[i]=tonumber(lista[i])
		end

		pilha[pilha.n] = lista[i]
		
		if(type(pilha[pilha.n])=='string') then
			if((pilha[pilha.n-2] and pilha[pilha.n-1]) == nil) then
				return('Falha na operação RPN')
			end

			if(pilha[pilha.n]=='+') then

				pilha[pilha.n-2] = pilha[pilha.n-2] + pilha[pilha.n-1]
				popNPilha(pilha,2)

			elseif(pilha[pilha.n]=='-') then

				pilha[pilha.n-2] = pilha[pilha.n-2] - pilha[pilha.n-1]
				popNPilha(pilha,2)

			elseif(pilha[pilha.n]=='*') then

				pilha[pilha.n-2] = pilha[pilha.n-2] * pilha[pilha.n-1]
				popNPilha(pilha,2)

			elseif(pilha[pilha.n]=='/') then

				pilha[pilha.n-2] = pilha[pilha.n-2] / pilha[pilha.n-1]
				popNPilha(pilha,2)
			elseif(pilha[pilha.n]=='^') then

				pilha[pilha.n-2] = pilha[pilha.n-2] ^ pilha[pilha.n-1]
				popNPilha(pilha,2)
			else
				popNPilha(pilha,1)
			end
		end

		pilha.n = pilha.n + 1
	end
end

function criaLista(msg)
	local lista = {}
	local n=1

	local x = string.find(msg,' ')

	while x~=nil do
		
		lista[n] = string.sub(msg,1,x-1)
		n = n + 1

		msg = string.sub(msg,x+1)

		x = string.find(msg,' ')
	end

	lista[n] = msg

	return lista
end
