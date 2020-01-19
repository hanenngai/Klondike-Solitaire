    unit
class Card
    import Heart in "Heart.t", Diamond in "Diamond.t", Spade in "Spade.t", Club in "Club.t"
    export setCard, setCentre, getcx, getcy, getSuit, getValue, draw, erase, setFace, getFace, inCard, inTopOfCard

    %declares suits and creates each object
    var spade : ^Spade
    var heart : ^Heart
    var club : ^Club
    var diamond : ^Diamond
    new spade
    new heart
    new club
    new diamond

    var cax : int := 150
    var cay : int := 100
    
    const caw : int := 30
    const cah : int := 40
    
    %Suit: 1 = spade, 2 = heart, 3 = club, 4 = diamond
    %Value: 1 = "A", 2 = "2" .. 11 = "J", 12 = "Q", 13 = "K"
    %Face: true = face up, false = face down
    %Default card: face down Ace of Spades
    var suit : int := 1
    var value : int := 1
    var face : boolean := false

    %sets each suit to size so that they fit in the cards
    ^spade.sethw (10, 12)
    ^heart.sethw (10, 12)
    ^club.sethw (10, 12)
    ^diamond.sethw (10, 12)

    %sets the card suit and value
    proc setCard (cardsuit, num : int)
	suit := cardsuit
	value := num
    end setCard

    %sets the center of the cards as well as the suit in the upper left
    proc setCentre (x, y : int)
	cax := x
	cay := y
	^spade.setCentre (cax + 25, cay + 38)
	^heart.setCentre (cax + 25, cay + 38)
	^club.setCentre (cax + 25, cay + 38)
	^diamond.setCentre (cax + 25, cay + 38)
    end setCentre
    
    %get the center x value
    fcn getcx : int
	result cax
    end getcx
    
    %get the center y value
    fcn getcy : int
	result cay
    end getcy
    
    %get the suit of the card
    fcn getSuit : int
	result suit
    end getSuit

    %get the value of the card
    fcn getValue : int
	result value
    end getValue

    %draw the card
    proc draw
	var c : int 
	var f : int := Font.New ("Times New Roman:10")
	if face = true then 
	    Draw.FillBox (cax - 35, cay - 50, cax + 35, cay + 50, 0)
	    Draw.Box (cax - 35, cay - 50, cax + 35, cay + 50, 7)
	    case suit of
		label 1 :
		    c := 7
		    ^spade.draw
		label 2 :
		    c := 12
		    ^heart.draw
		label 3 :
		    c := 7
		    ^club.draw
		label 4 :
		    c := 12
		    ^diamond.draw
	    end case
	    case value of
		label 1 : 
		    Draw.Text ("A", cax - 30, cay + 34, f, c)
		label 10 :
		    Draw.Text ("10", cax - 33, cay + 34, f, c) 
		label 11 :
		    Draw.Text ("J", cax - 28, cay + 34, f, c)
		label 12 :
		    Draw.Text ("Q", cax - 31, cay + 34, f, c)
		label 13 :
		    Draw.Text ("K", cax - 30, cay + 34, f, c)
		label :
		    Draw.Text (intstr(value), cax - 29, cay + 34, f, c)                    
	    end case
	else 
	    Draw.FillBox (cax - 35, cay - 50, cax + 35, cay + 50, 0)
	    Draw.FillBox (cax - 30, cay - 45, cax + 30, cay + 45, 87)
	    Draw.Box (cax - 35, cay - 50, cax + 35, cay + 50, 7)
	end if
    end draw

    proc erase
	Draw.FillBox (cax - 35, cay - 50, cax + 35, cay + 50, colourbg)
    end erase

    proc setFace (b : boolean)
	face := b
    end setFace
    
    fcn getFace : boolean
	result face
    end getFace
    
    fcn inCard (x, y : int) : boolean
	if x <= cax + 35 and x >= cax - 35 and y <= cay + 50 and y >= cay - 50 then
	    result true
	end if
	result false
    end inCard

    fcn inTopOfCard(x, y : int) : boolean
	if x <= cax + 35 and x >= cax - 35 and y <= cay + 50 and y >= cay + 25 then
	    result true
	end if
	result false
    end inTopOfCard

end Card


