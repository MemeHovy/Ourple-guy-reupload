_G.alive = true
spitehp = {}
spitegroup = {}
stunholder = {}
counter = 4
spitealive = {}
spiteOgX = {}
--i love tables
curType = ''
default = true
function onCreate() 
	setProperty('skipCountdown', true)
	setProperty('camZooming', true)
	setObjectOrder('dadGroup', getObjectOrder('dadGroup') + 2)
	setObjectOrder('gfGroup', getObjectOrder('gfGroup') + 2)
	
	makeLuaSprite('void','flesh', 605, 3881)
	addLuaSprite('void', false)
	
	makeAnimatedLuaSprite('dee', 'bounces', 4300.15, 4791.75);
	addAnimationByPrefix('dee', 'dance', 'dee idle', 30, false);
	addAnimationByPrefix('dee', 'die', 'dee dead', 30, true);
	objectPlayAnimation('dee', 'dance', true);
	
	--addLuaSprite('dee', true)
	
	makeAnimatedLuaSprite('steven', 'bounces', 4395.4, 4977.65);
	addAnimationByPrefix('steven', 'dance', 'steven dance', 30, false);
	addAnimationByPrefix('steven', 'die', 'steven dead', 30, true);
	objectPlayAnimation('steven', 'dance', true);
	
	addLuaSprite('steven', true)
	
	makeAnimatedLuaSprite('peter', 'bounces', 4721.25, 5133.3);
	addAnimationByPrefix('peter', 'dance', 'peter idle', 30, false);
	addAnimationByPrefix('peter', 'die', 'peter dead', 30, true);
	objectPlayAnimation('peter', 'dance', true);
	
	addLuaSprite('peter', true)
	
	makeAnimatedLuaSprite('blackjack', 'bounces', 4842.55, 4842.55);
	addAnimationByPrefix('blackjack', 'dance', 'blackjack idle', 30, false);
	addAnimationByPrefix('blackjack', 'die', 'blackjack dead', 30, false);
	objectPlayAnimation('blackjack', 'dance', true);
	doTweenY('floatUp', 'blackjack', getProperty('blackjack.y') - 150, 2, 'sineInOut')
	
	addLuaSprite('blackjack', true)
	
	makeLuaSprite('spite1', 'spite/spite1', 2436.65, 5212.2); --bottom right
	addLuaSprite('spite1', true)
	spitegroup[1] = getProperty('spite1')
	stunholder[1] = false
	spitealive[1] = true
	spitehp[1] = 100
	spiteOgX[1] = getProperty('spite1.x')
	
	makeLuaSprite('spite2', 'spite/spite2', 2210.05, 4413.45); --upper right
	addLuaSprite('spite2', true)
	spitegroup[2] = getProperty('spite2')
	stunholder[2] = false
	spitealive[2] = true
	spitehp[2] = 100
	spiteOgX[2] = getProperty('spite2.x')
	
	makeLuaSprite('spite3', 'spite/spite3', 1542.55, 5224.85); --bottom left
	addLuaSprite('spite3', true)
	spitegroup[3] = getProperty('spite3')
	stunholder[3] = false
	spitealive[3] = true
	spitehp[3] = 100
	spiteOgX[3] = getProperty('spite3.x')
	
	makeLuaSprite('spite4', 'spite/spite4', 1572.2, 4519.8); --upper left
	addLuaSprite('spite4', true)
	spitegroup[4] = getProperty('spite4')
	stunholder[4] = false
	spitealive[4] = true
	spitehp[4] = 100
	spiteOgX[4] = getProperty('spite4.x')
	
	makeLuaText('WEAKENED', 'WEAKENED!', 305, (getPropertyFromClass('flixel.FlxG', 'width') * 0.39), (getPropertyFromClass('flixel.FlxG', 'height') * 0.75))
	setTextAlignment('WEAKENED', 'center')
	setProperty('WEAKENED.alpha', 0)
	setTextSize('WEAKENED', 50)
	setTextBorder('WEAKENED', 2, 'FFFFFF')
	setTextColor('WEAKENED', 'D60A0A')
	--setTextFont('WEAKENED', 'Arial Narrow')
	setTextItalic('WEAKENED', true)
	addLuaText('WEAKENED')
	
	for i,object in pairs(spitegroup) do
		doTweenY('floatDownS'..i, object, getProperty(object..'.y') + 150, 2 + i/100, 'sineInOut')
	end
	
	makeLuaSprite('barup','',-34.95,-160.95)
	makeGraphic('barup',1348.9,281,'000000')
	addLuaSprite('barup',true)
    setScrollFactor('barup',0,0)
    setObjectCamera('barup','hud')

	makeLuaSprite('bardown','',-26,630.45)
	makeGraphic('bardown',1348.9,281,'000000')
	addLuaSprite('bardown',true)
    setScrollFactor('bardown',0,0)
    setObjectCamera('bardown','hud')
	
	makeLuaSprite('black','', -1500, -1500)
	makeGraphic('black', 5000, 5000, '000000')
	addLuaSprite('black', true)
    setScrollFactor('black',0,0)
   -- setObjectCamera('black','hud')
	setProperty('camHUD.visible', false)
	
	for b=1,16 do
		tag = tostring(b)
		precacheImage('flashback/'..tag)
		
		makeLuaSprite(tag,'flashback/'..tag, 0, 0)
		--scaleObject(tag, 1.5, 1.5)
		--updateHitbox(tag)
		--setObjectCamera(tag, 'other')
		addLuaSprite(tag,true)
	end
end

function onCreatePost()
	duration = getPropertyFromClass('Conductor', 'stepCrochet') * 8 / 1000
end
function opponentNoteHit(id, direction, noteType, isSustainNote)
	if getProperty('health') > 0.2 then
		if counter > 0 then
			damage = counter * 1.7 / 100
			setProperty('health', (getProperty('health')) - damage)
		end
	end
end

function onTweenCompleted(tag)
	if _G.alive == true then
		if tag == 'floatDown' then
			doTweenY('floatUp', 'blackjack', getProperty('blackjack.y') - 150, duration, 'sineInOut')
		end
		
		if tag == 'floatUp' then
			doTweenY('floatDown', 'blackjack', getProperty('blackjack.y') + 150, duration, 'sineInOut')
		end
	end
	
	if tag == 'Bounce' then 
		doTweenY('Fall', 'WEAKENED', getProperty('WEAKENED.y') + 200, 0.6, 'sineIn')
		--doTweenX('BounceX', 'WEAKENED', getProperty('WEAKENED.x') + 30, 0.3, 'sineOut')
	end
	
	if tag == 'BounceX' then 
		--doTweenY('Fall', 'WEAKENED', getProperty('WEAKENED.y') + 150, 0.6, 'cubeIn')
		doTweenX('FallX', 'WEAKENED', getProperty('WEAKENED.x') + 70, 0.6, 'sineIn')
	end
		
	for i,object in pairs(spitegroup) do
	
		if stunholder[i] == false and spitehp[i] > 0 and object ~= nil then
			if tag == 'floatDownS'..i then
				doTweenY('floatUpS'..i, object, getProperty(object..'.y') - 150, 2 + i/100, 'sineInOut')
			end
			
			if tag == 'floatUpS'..i then
				doTweenY('floatDownS'..i, object, getProperty(object..'.y') + 150, 2 + i/100, 'sineInOut')
			end
		end
		
		if object ~= nil then
			if tag == 'knockbackS'..i then
				if spitehp[i] < 1 then
					doTweenAlpha('fadeS'..i, object, 0, 0.2, 'sineIn')
				else
					doTweenX('moveBackS'..i, object, spiteOgX[i], 0.2, 'sineIn')
				end
			end
			
			if tag == 'fadeS'..i then
				removeLuaSprite(object)
			end
		end
	end
end

function onEvent(n,v1,v2)

	if n == 'Object Play Animation' then
		if v2 == 'die' then
			if v1 == 'blackjack' then
				_G.alive = false
			end
		end
	end
	
	if n == 'Set Note Type' then
		curType = v1
		if curType == 'bf' or curType == 'BF' then
			curType = ''
		end
		if curType == '' or curType == 'GF Sing' then
			default = true
		else
			default = false
		end
	end

end

function onBeatHit()
	-- triggered 4 times per section
	
	if curBeat % 2 == 0 then
		if getProperty('dee.animation.curAnim.name') == 'dance' then
			objectPlayAnimation('dee', 'dance', true)
		end
		
		if getProperty('steven.animation.curAnim.name') == 'dance' then
			objectPlayAnimation('steven', 'dance', true)
		end
		
		if getProperty('peter.animation.curAnim.name') == 'dance' then
			objectPlayAnimation('peter', 'dance', true)
		end
	end
	
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Spite Note' then
	
		--triggerEvent('Play Animation', 'singLEFT', 'bf')
		local index = 1
		setProperty('defaultCamZoom', 0.3)
		
			if noteData == 0 then
				spitehp[index] = spitehp[index] - 10

				if spitealive[index] == true and spitehp[index] < 1 then
					finalHit(index)
				end
				
				for i,object in pairs(spitegroup) do
					if i == index then
						doTweenX('knockbackS'..i, object, getProperty(object..'.x') - 150, 0.2, 'cubeOut')
					end
				end
				
			elseif noteData == 1 then
				index = 2
				spitehp[index] = spitehp[index] - 10

				if spitealive[index] == true and spitehp[index] < 1 then
					finalHit(index)
				end
				
				
				for i,object in pairs(spitegroup) do
					if i == index then
						doTweenX('knockbackS'..i, object, getProperty(object..'.x') - 150, 0.2, 'cubeOut')
					end
				end
				
			elseif noteData == 2 then
				index = 3
				spitehp[index] = spitehp[index] - 10

				if spitealive[index] == true and spitehp[index] < 1 then
					finalHit(index)
				end

				for i,object in pairs(spitegroup) do
					if i == index then
						doTweenX('knockbackS'..i, object, getProperty(object..'.x') - 150, 0.2, 'cubeOut')
					end
				end
				
			elseif noteData == 3 then
				index = 4
				spitehp[index] = spitehp[index] - 10
				
				if spitealive[index] == true and spitehp[index] < 1 then
					finalHit(index)
				end
				
				for i,object in pairs(spitegroup) do
					if i == index then
						doTweenX('knockbackS'..i, object, getProperty(object..'.x') - 150, 0.2, 'cubeOut')
					end
				end
				
			end
	end
end

function finalHit(index)
	cancelTween('Fall')
	cancelTween('FallX')
	cancelTween('Bounce')
	cancelTween('BounceX')
	setProperty('WEAKENED.y', (getPropertyFromClass('flixel.FlxG', 'height') * 0.75))
	setProperty('WEAKENED.x', (getPropertyFromClass('flixel.FlxG', 'width') * 0.39))
	setProperty('WEAKENED.alpha', 1)
	doTweenY('Bounce', 'WEAKENED', getProperty('WEAKENED.y') - 20, 0.3, 'sineOut')
	doTweenX('BounceX', 'WEAKENED', getProperty('WEAKENED.x') + 30, 0.3, 'sineOut')
	spitealive[index] = false
	counter = counter - 1
end

function onUpdate(elapsed)
	if getProperty('WEAKENED.alpha') > 0 then
		setProperty('WEAKENED.alpha', getProperty('WEAKENED.alpha') - 0.02)
	end
	
	for i = 0, getProperty('notes.length')-1 do
		if spitehp[getPropertyFromGroup('notes', i, 'noteData') + 1] < 1 and 
			getPropertyFromGroup('notes', i, 'noteType') == 'Spite Note' then
				--debugPrint('removed spite note'..tostring(getPropertyFromGroup('notes', i, 'noteData') + 1))
				removeFromGroup('notes', i)
		end
		
		if getPropertyFromGroup('notes', i, 'mustPress') then
			setPropertyFromGroup('notes', i, 'noteType', curType)
			if curType == 'GF Sing' then
				setPropertyFromGroup('notes', i, 'gfNote', true)
			else
				setPropertyFromGroup('notes', i, 'gfNote', false)
			end
			if not default then
				setPropertyFromGroup('notes', i, 'noAnimation', true)
			else
				setPropertyFromGroup('notes', i, 'noAnimation', false)
			end
		end
	end
	
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if spitehp[getPropertyFromGroup('unspawnNotes', i, 'noteData') + 1] < 1 and 
			getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Spite Note' then
				--debugPrint('removed spite unspawnNote'..tostring(getPropertyFromGroup('unspawnNotes', i, 'noteData') + 1))
				removeFromGroup('unspawnNotes', i)
		end
	end

	if mustHitSection == false then
		setProperty('defaultCamZoom', 0.45)
	else
		setProperty('defaultCamZoom', 0.35)
	end
end 