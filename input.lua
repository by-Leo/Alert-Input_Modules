function input(title, text, textListener, listener)
  local inputGroup = display.newGroup()
  local inputButtonResizeWidth = 248 / 1.1
  local inputButtonResizeHeight = 101.6 / 1.1
  alertActive = true

  local function onKeyEventInput( event )
    if (event.keyName == "back" or event.keyName == "escape") and event.phase == 'up' then
      native.setKeyboardFocus(nil)
      alertActive = false
      inputGroup:removeSelf()
      Runtime:removeEventListener( "key", onKeyEventInput )
      listener({input = false})
    end
    return true
  end
  Runtime:addEventListener( "key", onKeyEventInput )

  local defaultBox = native.newTextBox( 5000, _y - 40, 510, 84 )
  timer.performWithDelay(1, function()
    defaultBox.x = _x
    defaultBox.isEditable = true
    defaultBox.hasBackground = false
    defaultBox.placeholder = text
    defaultBox.font = native.newFont( 'sans.ttf', 30 )
    defaultBox.inputType = 'no-emoji'
    -- if system.getInfo('platform') == 'android' then
    --   defaultBox:setTextColor(0.9)
    -- else
      defaultBox:setTextColor(0.1)
    -- end
    defaultBox:addEventListener( "userInput", textListener )
    inputGroup:insert(defaultBox)

    local inputRect = display.newImage(inputGroup, 'Image/alert.png')
      inputRect.x = _x
      inputRect.y = _y
      inputRect.width = 576
      inputRect.height = 360
    local inputLine = display.newRect(inputGroup, _x, _y + 12, 504, 3)

    local inputTitle = display.newText({
      parent = inputGroup, text = title,
      width = 500, height = 50,
      font = 'sans_bold.ttf', fontSize = 36,
      x = _x - 252, y = _y - 125
    })
    inputTitle.anchorX = 0

    inputButton = display.newImage(inputGroup, 'Image/listbut.png')
      inputButton.x = _x + 128
      inputButton.y = _y + 94
      inputButton.width = 248
      inputButton.height = 101.6
    inputText = display.newText({
      parent = inputGroup, font = 'sans_bold.ttf',
      width = 180, height = 80, text = 'Ок',
      x = _x + 128, y = _y + 114, fontSize = 26, align = 'center'
    })
    inputButton.alpha = 0.2
    inputText.alpha = 0.2

    inputButton:addEventListener('touch', function(e)
      if inputButton.alpha > 0.5 then
        native.setKeyboardFocus(nil)
        if e.phase == 'began' then
          display.getCurrentStage():setFocus( e.target )
          e.target.width = inputButtonResizeWidth
          e.target.height = inputButtonResizeHeight
        elseif e.phase == 'ended' or e.phase == 'cancelled' then
          display.getCurrentStage():setFocus( nil )
          e.target.width = 248
          e.target.height = 101.6

          alertActive = false
          inputGroup:removeSelf()
          Runtime:removeEventListener( "key", onKeyEventInput )
          listener({text = defaultBox.text, input = true})
        end
      end
      return true
    end)
  end)
end
