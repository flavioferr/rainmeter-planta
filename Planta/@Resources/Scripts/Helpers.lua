-- Funcoes chamadas inline nos textos: [&ScriptHelpers:Quote()]

function Initialize()
end

-- frase do dia: Quote1..QuoteN, muda a cada dia
function Quote()
	local count = tonumber(SKIN:GetVariable('QuoteCount')) or 1
	local idx = (os.date('*t').yday % count) + 1
	return SKIN:GetVariable('Quote' .. idx) or ''
end

function Author()
	local count = tonumber(SKIN:GetVariable('QuoteCount')) or 1
	local idx = (os.date('*t').yday % count) + 1
	return SKIN:GetVariable('Author' .. idx) or ''
end

-- barra em ASCII: Bar(75, 20) -> "###############-----"
function Bar(pct, n)
	pct = math.max(0, math.min(100, tonumber(pct) or 0))
	local k = math.floor(pct / 100 * n + 0.5)
	return string.rep('#', k) .. string.rep('-', n - k)
end

-- byte em hexadecimal: Hex(122) -> "0x7A"
function Hex(v)
	return string.format('0x%02X', math.floor(tonumber(v) or 0))
end

-- volume a partir da posicao vertical do clique (0% embaixo, 100% em cima)
function VolFromY(y)
	local v = 100 - math.floor(tonumber(y) or 0)
	SKIN:Bang('!CommandMeasure', 'MeasureVol', 'SetVolume ' .. math.max(0, math.min(100, v)))
end
