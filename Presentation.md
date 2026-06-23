````markdown
# 🌌 UnknownLib Documentation

Welcome to **UnknownLib**, a lightweight and customizable Roblox UI library.

## 🚀 Booting the Library

```lua
local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/UknownHub/UnknownLib/refs/heads/main/UnknownLib.lua"))()
```

---

## 🪟 Creating a Window

```lua
local Window = Lib:CreateWindow({
    Title = "My Hub",
    ToggleKey = Enum.KeyCode.RightShift,
})

--[[
Title = <string> - The title displayed on the window.
ToggleKey = <Enum.KeyCode> - The key used to show or hide the UI.
]]
```

---

## 📂 Creating a Tab

```lua
local Main = Window:AddTab("Main")
```

---

## 🏷️ Creating a Section

```lua
Main:AddSection("Main Features")
```

---

## 🔘 Creating a Button

```lua
Main:AddButton({
    Text = "Click Me",
    Callback = function()
        -- Your code here
    end,
})

--[[
Text = <string> - Text displayed on the button.
Callback = <function> - Function executed when clicked.
]]
```

---

## ✅ Creating a Toggle

```lua
local Toggle = Main:AddToggle({
    Text = "Enable Feature",
    Default = false,
    Callback = function(Value)
        -- Your code here
    end,
})

--[[
Text = <string> - Toggle label.
Default = <boolean> - Default state.
Callback = <function> - Runs when toggled.
]]
```

### Change Toggle State

```lua
Toggle:Set(true)
```

---

## 🎚️ Creating a Slider

```lua
local Slider = Main:AddSlider({
    Text = "Walk Speed",
    Min = 16,
    Max = 100,
    Default = 16,
    Callback = function(Value)
        -- Your code here
    end,
})

--[[
Text = <string> - Slider label.
Min = <number> - Minimum value.
Max = <number> - Maximum value.
Default = <number> - Starting value.
Callback = <function> - Runs when value changes.
]]
```

### Change Slider Value

```lua
Slider:Set(50)
```

---

## 📜 Creating a Dropdown

```lua
local Dropdown = Main:AddDropdown({
    Options = {
        "Option 1",
        "Option 2",
        "Option 3"
    },
    Default = "Option 1",
    Callback = function(Value)
        -- Your code here
    end,
})

--[[
Options = <table> - Available selections.
Default = <string> - Default selected option.
Callback = <function> - Runs when selection changes.
]]
```

### Change Selected Option

```lua
Dropdown:Set("Option 2")
```

---

## 🔔 Creating a Notification

```lua
Main:AddNotification({
    Text = "Library Loaded!",
    Type = "success",
})

--[[
Text = <string> - Notification message.
Type = <string> - "info", "success", "warning", or "error".
]]
```

---

## ⌨️ Creating a Keybind

```lua
local Bind = Main:AddKeybind({
    Text = "Toggle UI",
    Key = Enum.KeyCode.RightShift,
    Callback = function(Key)
        -- Your code here
    end,
})

--[[
Text = <string> - Label shown beside the keybind.
Key = <Enum.KeyCode> - Default assigned key.
Callback = <function> - Runs when the keybind changes.
]]
```

### Get the Current Key

```lua
print(Bind:Get())
```

---

# 🎉 That's it!

You're now ready to build interfaces with **UnknownLib**.
Simply create a window, add tabs, and start placing components with your own logic inside:

```lua
-- Your code here
```
````
