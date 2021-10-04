Grid = {

  init = function(screenWidth, screenHeight, resolution)

    local _grid = {}

    _grid.focusedPoint = nil

    for i = 1, screenWidth/resolution-1 do

      _grid[i] = {}

      for j = 1, screenHeight/resolution-1 do

        local _x = resolution * i
        local _y = resolution * j

        _grid[i][j] = {x=_x, y=_y, focus=false}

      end
    end

    _grid.update = function(dt)
      for i = 1, screenWidth/resolution-1 do
        for j = 1, screenHeight/resolution-1 do
          local _point = _grid[i][j]
          local _distance = math.sqrt(math.pow((love.mouse.getX()-_point.x), 2)+math.pow((love.mouse.getY()-_point.y), 2))
          if _distance < 5 then
            _point.focus = true
            _grid.focusedPoint = {x=_point.x, y=_point.y}
            --print("Point x : " .. _grid.focusedPoint.x .. ", y : " .. _grid.focusedPoint.y)
            return
          else
            _point.focus = false
            _grid.focusedPoint = nil
          end
          _grid[i][j] = _point
        end
      end
    end

    _grid.draw = function()

      love.graphics.setLineWidth(1)

      for i = 1, screenWidth/resolution-1 do
        for j = 1, screenHeight/resolution-1 do
          local _point = _grid[i][j]
          love.graphics.circle('fill', _point.x, _point.y, 1, 4)
          if _point.focus then
            love.graphics.circle('line', _point.x, _point.y, 8, 16)
          end
        end
      end
    end


    return _grid

  end
}

return Grid
