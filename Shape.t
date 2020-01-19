unit %This is the superclass made for Unit 1 Assignments
class Shape
    export setCentre, sethw, getCentreX, getCentreY, getWidth, getHeight, getColour, draw, erase
    
    var cx, cy, w, h, c : int
    
    cx := 320 %x coordinate of the center
    cy := 200 %y coordinate of the center
    w := 40 %width
    h := 50 %height
    c := 7 %colour (default is black)
    
    %Setter method for the center of the shape
    proc setCentre (x, y : int)
	cx := x
	cy := y
    end setCentre
    
    %Setter method for the dimensions of the shape
    proc sethw(x, y : int)
	w := x
	h := y
    end sethw
    
    %Getter method for the x coordinate of the center
    fcn getCentreX : int
	result cx
    end getCentreX
    
    %Getter method for the y coordinate of the center
    fcn getCentreY : int
	result cy
    end getCentreY
    
    %Getter method for the width
    fcn getWidth : int
	result w
    end getWidth
    
    %Getter method for the height
    fcn getHeight : int
	result h
    end getHeight
    
    %Getter method for the colour
    fcn getColour : int
	result c
    end getColour

    %deferred proc is used to define the erase procedure below 
    %proc erase will call draw, but draw has not yet been defined. Every class that inherits Shape has different draw procedures so it is deferred to "trick" turing into thinking it exists
    deferred proc draw
    
    %sets color to white, draws over old image with white to "erase" it, resets color back to original colour
    proc erase
	var oc : int := getColour
	c := colourbg
	draw
	c := oc
    end erase    
    
end Shape
