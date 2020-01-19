unit
class Club
    %Inherits methods from Shape.t
    inherit Shape in "Shape.t"

    %Set color to black, width and height specified for use in the cards
    c := 7
    w := 20
    h := 25

    %Draws the club shape
    body proc draw
	Draw.FillOval (cx - w div 4, cy - h div 8, w div 4, h div 4, c)
	Draw.FillOval (cx + w div 4, cy - h div 8, w div 4, h div 4, c)
	Draw.FillOval (cx, cy + h div 4, w div 4, h div 4, c)
	Draw.FillBox (cx - w div 15, cy - h div 2, cx + w div 15, cy, c)
	Draw.Dot(cx, cy + h div 2, white)
    end draw
end Club

