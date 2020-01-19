unit
class Spade
    %Inherits methods from Shape.t
    inherit Shape in "Shape.t"

    %Set color to black, width and height specified for use in the cards
    c := 7
    w := 20
    h := 25
    
    %Draws the spade shape
    body proc draw
	var x, y : array 1 .. 3 of int
	x (1) := cx - w div 2
	y (1) := cy - h div 8
	x (2) := cx + w div 2
	y (2) := cy - h div 8
	x (3) := cx
	y (3) := cy + h div 2
	Draw.FillPolygon (x, y, 3, c)
	Draw.FillArc (cx - w div 4, cy - h div 8, w div 4, h div 4, 180, 360, c)
	Draw.FillArc (cx + w div 4, cy - h div 8, w div 4, h div 4, 180, 360, c)
	Draw.FillBox (cx - w div 15, cy - h div 2, cx + w div 15, cy, c)
    end draw

end Spade
