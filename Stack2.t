unit
class Stack2
    import Card in "Card.t"
    export setCentre, getX, getY, getC, getStackUpper, lastCard, addCard, removeCard, setAllFlipped, moveIsValid, draw, isInside
    
    var a : flexible array 1 .. 0 of ^Card

    %Default center variables
    var x := 0
    var y := 0

    %Setter method for the centre values
    proc setCentre (newX, newY : int)
	x := newX
	y := newY
	if upper (a) > 0 then
	    for i : 1 .. upper (a)
		^ (a (i)).setCentre (x, y)
	    end for
	end if
    end setCentre

    %Getter method for the centre x coordinate of the top card 
    fcn getX : int
	result x
    end getX

    %Getter method for the center y coordinate of the top card
    fcn getY : int
	result y
    end getY

    %Getter method for a specific card in the stack
    fcn getC (i : int) : ^Card
	result a (i)
    end getC

    %Getter method for the upperbound of the array
    fcn getStackUpper : int
	result upper (a)
    end getStackUpper
    
    %Getter method for the last card in the deck
    fcn lastCard : ^Card
	result a (upper (a))
    end lastCard

    %Add a card to the stack
    proc addCard (nc : ^Card)
	new a, upper (a) + 1
	new a (upper (a))
	^lastCard.setCard ( ^nc.getSuit, ^nc.getValue)
	^lastCard.setCentre (x, y)
	^lastCard.setFace (true)
    end addCard

    %Remove the top card from the stack
    proc removeCard
	new a, upper (a) - 1
    end removeCard

    %Set all cards flipped to the same boolean value
    proc setAllFlipped (tf : boolean)
	if upper (a) > 0 then
	    for i : 1 .. upper (a)
		^ (a (i)).setFace (tf)
	    end for
	end if
    end setAllFlipped

    %Checks if the card can be added into the deck
    fcn moveIsValid (nc : ^Card) : boolean
	if upper(a) = 0 and ^nc.getValue = 1 then
	    result true
	end if
	if ^nc.getValue = upper (a) + 1 then
	    if upper (a) > 0 and ^nc.getSuit = ^lastCard.getSuit then
		result true
	    end if
	end if
	result false
    end moveIsValid

    %Draw the cards to the screen
    proc draw
	if upper (a) = 0 then
	    Draw.Box (x - 35, y - 50, x + 35, y + 50, black)
	else
	    ^lastCard.draw
	end if
    end draw
    
    %Checks if the mouse is inside the box
    fcn isInside (mx, my : int) : boolean
	if mx > x - 35 and mx < x + 35 and my > y - 50 and my < y + 50 then
	    result true
	end if
	result false
    end isInside

end Stack2
