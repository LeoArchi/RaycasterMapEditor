Grid = require "grid"

local _screenWidth
local _screenHeight
local _defaultGrid
local _pointA
local _mapSegments

function love.load()

  _mapSegments = {}

  _screenWidth = love.graphics.getWidth()
  _screenHeight = love.graphics.getHeight()

  _defaultGrid = Grid.init(_screenWidth, _screenHeight, 10)

end


function love.update(dt)
  _defaultGrid.update(dt)
end



function love.draw()

  love.graphics.setBackgroundColor(0.2, 0.2, 0.2)

  love.graphics.setColor(1, 1, 1)
  love.graphics.setLineWidth(3)

  _defaultGrid.draw()

  if _pointA ~= nil and _pointB == nil then
    love.graphics.setColor(1, 0, 0)
    love.graphics.line(_pointA.x, _pointA.y, love.mouse.getX(), love.mouse.getY())
  end

  for i, segment in ipairs(_mapSegments) do
    love.graphics.setColor(1, 0, 0)
    love.graphics.line(segment.x1, segment.y1, segment.x2, segment.y2)
  end

end




function love.mousepressed(x, y, button)
  -- Cick gauche, si on a le focus sur un point de la grille, on sauvegarde ce point comme premier point d'un nouveau segment
   if button == 1 then
     if _defaultGrid.focusedPoint ~= nil then
       if _pointA == nil then
         _pointA = _defaultGrid.focusedPoint
       elseif _pointA ~= nil then
         table.insert(_mapSegments,{x1=_pointA.x, y1=_pointA.y, x2=_defaultGrid.focusedPoint.x, y2=_defaultGrid.focusedPoint.y})
         _pointA = nil
       end
     end
   end

   -- Click droit, si un premier point est sauvegardé, on annule
   if button == 2 then
     print("click droit")
     if _pointA ~= nil then
       print("conditions ok")
       _pointA = nil
     else
       table.remove(_mapSegments, table.getn(_mapSegments))
     end
   end

end
