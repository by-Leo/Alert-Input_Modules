function alert(title, text, buttons, listener)
  local alertGroup = display.newGroup()
  local alertButtonResizeWidth = 248 / 1.1
  local alertButtonResizeHeight = 101.6 / 1.1
  alertActive = true

  local function onKeyEventAlert( event )
    if (event.keyName == "back" or event.keyName == "escape") and event.phase == 'up' then
      alertActive = false
      alertGroup:removeSelf()
      Runtime:removeEventListener( "key", onKeyEventAlert )
      listener({num = 0})
    end
    return true
  end
  Runtime:addEventListener( "key", onKeyEventAlert )

  local alertRect = display.newImage(alertGroup, 'Image/alert.png')
    alertRect.x = _x
    alertRect.y = _y
    alertRect.width = 576
    alertRect.height = 360

  local alertTitle = display.newText({
    parent = alertGroup, text = title,
    width = 500, height = 50,
    font = 'sans_bold.ttf', fontSize = 36,
    x = _x - 252, y = _y - 125
  })
  alertTitle.anchorX = 0
  local alertText = display.newText({
    parent = alertGroup, font = 'sans.ttf',
    width = 500, height = 120, text = text,
    x = _x - 252, y = _y - 40, fontSize = 22
  })
  alertText.anchorX = 0

  local buttonX = function() if #buttons == 1 then return _x + 128 else return _x - 128 end end

  local alertButton1 = display.newImage(alertGroup, 'Image/listbut.png')
    alertButton1.x = buttonX()
    alertButton1.y = _y + 94
    alertButton1.width = 248
    alertButton1.height = 101.6
  local alertText1 = display.newText({
    parent = alertGroup, font = 'sans_bold.ttf',
    width = 180, height = 80, text = buttons[1],
    x = buttonX(), y = _y + 94, fontSize = 20, align = 'center'
  })
  local alertButton2
  local alertText2

  alertButton1:addEventListener('touch', function(e)
    if e.phase == 'began' then
      display.getCurrentStage():setFocus( e.target )
      e.target.width = alertButtonResizeWidth
      e.target.height = alertButtonResizeHeight
      alertText1.y = _y + 99
      if #buttons > 1 then
        alertButton2.alpha = 0.7
        alertText2.alpha = 0.7
      end
    elseif e.phase == 'ended' or e.phase == 'cancelled' then
      display.getCurrentStage():setFocus( nil )
      e.target.width = 248
      e.target.height = 101.6
      alertText1.y = _y + 94
      if #buttons > 1 then
        alertButton2.alpha = 1
        alertText2.alpha = 1
      end

      alertActive = false
      alertGroup:removeSelf()
      Runtime:removeEventListener( "key", onKeyEventAlert )
      listener({num = 1})
    end
    return true
  end)

  if #buttons > 1 then
    alertButton2 = display.newImage(alertGroup, 'Image/listbut.png')
      alertButton2.x = _x + 128
      alertButton2.y = _y + 94
      alertButton2.width = 248
      alertButton2.height = 101.6
    alertText2 = display.newText({
      parent = alertGroup, font = 'sans_bold.ttf',
      width = 180, height = 80, text = buttons[2],
      x = _x + 128, y = _y + 94, fontSize = 20, align = 'center'
    })

    alertButton2:addEventListener('touch', function(e)
      if e.phase == 'began' then
        display.getCurrentStage():setFocus( e.target )
        e.target.width = alertButtonResizeWidth
        e.target.height = alertButtonResizeHeight
        alertText2.y = _y + 99
        alertButton1.alpha = 0.7
        alertText1.alpha = 0.7
      elseif e.phase == 'ended' or e.phase == 'cancelled' then
        display.getCurrentStage():setFocus( nil )
        e.target.width = 248
        e.target.height = 101.6
        alertText2.y = _y + 94
        alertButton1.alpha = 1
        alertText1.alpha = 1

        alertActive = false
        alertGroup:removeSelf()
        Runtime:removeEventListener( "key", onKeyEventAlert )
        listener({num = 2})
      end
      return true
    end)
  end
end
