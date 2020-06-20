# Alert-Input_Modules
Modules for creating a window for receiving information from a user

## Initialization
Just copy the function to main.lua 

## Usage Input
```lua
input('Title', 'Description', function (event)
  if ( event.phase == "editing" ) then
    print( event.text )
  end
end, function(e)
  -- Man finished writing text
  if e.input then
    -- The text he entered
    print(e.text)
  end
end)
```

## Usage Alert
```lua
alert('Title', 'Description', {...Buttons...}, function(e)
  if e.num == 1 then
    print('Button "1" was pressed')
  end
end)
```

## Example 
```lua
function inputTest()
  input('Enter something', 'Enter something in the text input field...', function (event)
  end, function(e)
    if e.input then
      alert(e.text, e.text, {'Close application', 'Enter something again'}, function(e)
        if e.num == 1 then 
          native.requestExit()
        elseif e.num == 2 then
          inputTest()
        end
      end)
    else
      inputTest()
    end
  end)
end
```
