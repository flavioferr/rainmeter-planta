-- Separa as listas da previsao (datas, codigos, maximas, minimas) em variaveis por dia.
-- Simbolos (definidos no ini como Sym0..Sym6): 0 sol, 1 sol e nuvem, 2 nuvem, 3 chuva, 4 neve, 5 tempestade, 6 neblina

function Initialize()
	for i = 1, 7 do
		SKIN:Bang('!SetVariable', 'FDow' .. i, (i - 1) % 7)
		SKIN:Bang('!SetVariable', 'FMax' .. i, '--')
		SKIN:Bang('!SetVariable', 'FMin' .. i, '--')
		SKIN:Bang('!SetVariable', 'FSym' .. i, 2)
	end
end

local function list(name)
	local out = {}
	local m = SKIN:GetMeasure(name)
	for v in string.gmatch(m and m:GetStringValue() or '', '[^,]+') do
		out[#out + 1] = v:gsub('"', '')
	end
	return out
end

local function sym(code)
	code = tonumber(code) or 3
	if code <= 0 then return 0 end
	if code <= 2 then return 1 end
	if code == 3 then return 2 end
	if code == 45 or code == 48 then return 6 end
	if code >= 95 then return 5 end
	if (code >= 71 and code <= 77) or code == 85 or code == 86 then return 4 end
	return 3
end

function Parse()
	local dates, codes, maxs, mins = list('MeasureFDates'), list('MeasureFCodes'), list('MeasureFMaxs'), list('MeasureFMins')
	for i = 1, math.min(7, #dates) do
		local y, mo, d = dates[i]:match('(%d+)-(%d+)-(%d+)')
		if y then
			local t = os.time { year = tonumber(y), month = tonumber(mo), day = tonumber(d), hour = 12 }
			SKIN:Bang('!SetVariable', 'FDow' .. i, tonumber(os.date('%w', t)))
		end
		SKIN:Bang('!SetVariable', 'FMax' .. i, string.format('%d', math.floor((tonumber(maxs[i]) or 0) + 0.5)))
		SKIN:Bang('!SetVariable', 'FMin' .. i, string.format('%d', math.floor((tonumber(mins[i]) or 0) + 0.5)))
		SKIN:Bang('!SetVariable', 'FSym' .. i, sym(codes[i]))
	end
	SKIN:Bang('!UpdateMeter', '*')
	SKIN:Bang('!Redraw')
end

function Update()
	return 0
end
