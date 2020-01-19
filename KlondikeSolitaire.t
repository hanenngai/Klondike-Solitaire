%% This game is Klondike Solitaire by Hanen Ngai and Leo Chiang
%% We built this game using the classes and superclasses of spade, heart, clubs, diamonds, shape, card, and deck made in class with modifications
%% Two new classes created called stack1 and stack2

import Card in "Card.t", Deck in "Deck.t", Stack1 in "Stack1.t", Stack2 in "Stack2.t", GUI

var last : boolean := false
var oldstack : int := 0
var oldfoundation : int := 0
var oldpile : int := 0
var deckclicked : boolean := false

setscreen ("graphics:800;600,nocursor")

var d : ^Deck
new d
var arr1 : array 1 .. 7 of ^Stack1
var arr2 : array 1 .. 4 of ^Stack2
var spare : ^Stack2
new spare
var c : ^Card
new c
var picID : int := Pic.FileNew ("background.bmp")
var font := Font.New ("serif:50")

%set up cards randomly in arrangement 
proc initialize
    ^d.shuffleDeck
    for i : 1 .. 7
	new arr1 (i)
	for j : 1 .. i
	    ^ (arr1 (i)).addCard ( ^d.drawCard)
	    ^ ( ^ (arr1 (i)).getC (j)).setFace (false)
	end for
	^ (arr1 (i)).flipLast
    end for
    for i : 1 .. 4
	new arr2 (i)
    end for
end initialize

%draw visuals of game
proc drawBoard
    cls
    Pic.Draw (picID, 0, 0, picUnderMerge)
    for i : 1 .. 7
	^ (arr1 (i)).setCentre (maxx div 8 * i, 350)
	^ (arr1 (i)).flipLast
	^ (arr1 (i)).draw
    end for
    for i : 1 .. 4
	^ (arr2 (i)).setCentre (maxx - (maxx div 9) * i, 500)
	^ (arr2 (i)).draw
    end for
    ^spare.setCentre (maxx div 9 * 2, 500)
    ^spare.draw
    if last = false then
	^c.setCentre (maxx div 9, 500)
	^c.draw
    end if
end drawBoard

%card clicked on is moved to corner
fcn firstSelect : ^Stack1
    var x, y, b1, b2 : int
    var b : boolean := false
    var stack : ^Stack1 := nil
    var card : ^Card := nil
    new stack
    new card
    loop
	exit when b = true
	Mouse.ButtonWait ("down", x, y, b1, b2)
	for i : 1 .. 7
	    if ^ (arr1 (i)).getStackUpper > 0 then
		for j : 1 .. ^ (arr1 (i)).getStackUpper
		    card := ^ (arr1 (i)).getC (j)
		    if ^card.inTopOfCard (x, y) = true and ^card.getFace = true then
			b := true
			for k : j .. ^ (arr1 (i)).getStackUpper
			    ^stack.addCard ( ^ (arr1 (i)).getC (k))
			end for
			for k : j .. ^ (arr1 (i)).getStackUpper
			    ^ (arr1 (i)).removeCard
			end for
			oldstack := i
			exit
		    end if
		end for
		if b = false and ^ ( ^ (arr1 (i)).lastCard).inCard (x, y) = true then
		    b := true
		    ^stack.addCard ( ^ (arr1 (i)).lastCard)
		    ^ (arr1 (i)).removeCard
		    oldstack := i
		    exit
		end if
	    end if
	end for
	if b = false then
	    for i : 1 .. 4
		if ^ (arr2 (i)).getStackUpper > 0 then
		    card := ^ (arr2 (i)).lastCard
		    if ^card.inCard (x, y) = true then
			b := true
			^stack.addCard ( ^ (arr2 (i)).lastCard)
			^ (arr2 (i)).removeCard
			oldstack := i
			exit
		    end if
		end if
	    end for
	end if
	if ^c.inCard (x, y) = true then
	    if ^d.getDeckSize > 0 and ^d.getDeckSize ~= 1 then
		^stack.addCard ( ^d.drawCard)
		^spare.addCard ( ^stack.getC (1))
	    elsif ^d.getDeckSize = 1 then
		^stack.addCard ( ^d.drawCard)
		^spare.addCard ( ^stack.getC (1))
		last := true
	    elsif ^d.getDeckSize = 0 then
		for i : 1 .. ^spare.getStackUpper
		    ^d.addCard ( ^spare.lastCard)
		    ^spare.removeCard
		end for
		last := false
	    end if
	    deckclicked := true
	    exit
	end if
	if ^spare.getStackUpper > 0 and ^spare.isInside (x, y) = true then
	    ^stack.addCard ( ^spare.lastCard)
	    ^spare.removeCard
	    exit
	end if
    end loop
    result stack
end firstSelect

%on second click, card is placed down
fcn secondSelect (s : ^Stack1) : boolean
    var x, y, b1, b2 : int
    Mouse.ButtonWait ("down", x, y, b1, b2)
    for i : 1 .. 7
	if ^ (arr1 (i)).getStackUpper > 0 then
	    if ^ ( ^ (arr1 (i)).lastCard).inCard (x, y) = true and ^ (arr1 (i)).moveIsValid ( ^s.getC (1)) = true then
		for j : 1 .. ^s.getStackUpper
		    ^ (arr1 (i)).addCard ( ^s.getC (j))
		end for
		result true
	    end if
	else
	    if ^ (arr1 (i)).isInside (x, y) = true then
		if ^ ( ^s.getC (1)).getValue = 13 then
		    for j : 1 .. ^s.getStackUpper
			^ (arr1 (i)).addCard ( ^s.getC (j))
		    end for
		    result true
		end if
	    end if
	end if
    end for
    if ^s.getStackUpper = 1 then
	for i : 1 .. 4
	    if ^ (arr2 (i)).isInside (x, y) = true and ^ (arr2 (i)).moveIsValid ( ^s.getC (1)) = true then
		^ (arr2 (i)).addCard ( ^s.getC (1))
		result true
	    end if
	end for
    end if
    result false
end secondSelect

%restock deck
proc restock (s : ^Stack1)
    if oldstack > 0 then
	for i : 1 .. ^s.getStackUpper
	    ^ (arr1 (oldstack)).addCard ( ^s.getC (i))
	end for
    elsif oldfoundation > 0 then
	^ (arr2 (oldfoundation)).addCard ( ^s.getC (1))
    else
	^spare.addCard ( ^s.getC (1))
    end if
end restock

%moves stacks
proc moveCards
    var stack : ^Stack1
    new stack
    stack := firstSelect
    ^stack.setCentre (60, 100)
    ^stack.draw
    if deckclicked = false and secondSelect (stack) = false then
	restock (stack)
    end if
end moveCards

%check if game is won 
fcn won : boolean
    for i : 1 .. 4
	if ^ (arr2 (i)).getStackUpper < 13 then
	    result false
	end if
    end for
    result true
end won

%end screen 
proc endscreen
    cls
    Pic.Draw (picID, 0, 0, picXor)
    Draw.Text ("YOU WIN!", maxx div 3.5 + 20, maxy div 2 + 20, font, white)
end endscreen

%main program
proc game
    initialize
    loop
	drawBoard
	oldstack := 0
	oldfoundation := 0
	oldpile := 0
	deckclicked := false
	if won = true then
	    endscreen
	end if
	exit when hasch or won = true
	moveCards
    end loop
end game

%proc loadscreen is declared for instruction
forward proc loadScreen

%instructions and back button
proc instruction
    cls
    Pic.Draw(picID,0,0,picUnderMerge)
    var font1 : int := Font.New ("serif:20")
    var font2 : int := Font.New ("serif:13")
    var font3 : int := Font.New ("serif:24:bold")
    Font.Draw ("Instructions", 340, 550, font3, white)
    Font.Draw ("Objective", 10, 520, font1, white)
    Font.Draw ("The goal of the game is to move all the cards to the four foundations, which are additional stacks", 20, 500, font2, white)
    Font.Draw ("of cards that are empty at the start of the game. Each stack represents a suit, and they must be", 20, 480, font2, white)
    Font.Draw ("stacked by suit and in order, starting from Ace and ending with King.", 20, 460, font2, white)
    Font.Draw ("Rules", 10, 410, font1, white)
    Font.Draw ("Cards that are face up and showing may be moved from the stock pile or the columns to the foundation", 20, 390, font2, white)
    Font.Draw ("stacks or to other columns. ", 20, 370, font2, white)
    Font.Draw ("To move a card to a column, it must be one less in rank and the opposite color.", 20, 350, font2, white)
    Font.Draw ("If you get an empty column, you can start a new column with a King.", 20, 330, font2, white)
    Font.Draw ("Click on the stock pile (top left) to go through the rest of cards.", 20, 310, font2, white)
    var backButton : int := GUI.CreateButton (20, 20, 0, "Back", loadScreen)
    loop
	exit when GUI.ProcessEvent
    end loop
end instruction

%loading screen with buttons
body proc loadScreen
    cls
    var font4 : int := Font.New ("mono:38:bold")
    Pic.Draw(picID,0,0,picUnderMerge)
    Font.Draw ("SOLITAIRE", 265,380, font4, white)
    var playButton : int := GUI.CreateButton (380, 300, 0, "Play", game)
    var instructButton : int := GUI.CreateButton (360, 250, 0, "Instructions", instruction)
    loop
	exit when GUI.ProcessEvent
    end loop
end loadScreen

%start of program
loadScreen


