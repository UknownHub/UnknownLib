# 🌠 UnknownLib

A lightweight Roblox UI library focused on simplicity and clean design.

## 📦 Installation

Import the latest version of UnknownLib:

```lua
local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/UknownHub/UnknownLib/refs/heads/main/UnknownLib.lua"))()
```

---

## 🪟 Create a Window

```lua
local Window = Lib:CreateWindow({
    Title = "Unknown Hub",
    ToggleKey = Enum.KeyCode.RightShift,
})
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `Title` | `string` | Text shown in the title bar. |
| `ToggleKey` | `Enum.KeyCode` | Key used to show or hide the interface. |

---

## 📁 Add a Tab

```lua
local Main = Window:AddTab("Main")
```

---

## 📌 Add a Section

```lua
Main:AddSection("Player")
```

---

## 🔘 Add a Button

```lua
Main:AddButton({
    Text = "Do Something",
    Callback = function()
        -- Your code here
    end,
})
```

---

## ✅ Add a Toggle

```lua
local Toggle = Main:AddToggle({
    Text = "Auto Farm",
    Default = false,
    Callback = function(state)
        -- Your code here
    end,
})
```

Update it later:

```lua
Toggle:Set(true)
```

---

## 🎚️ Add a Slider

```lua
local Slider = Main:AddSlider({
    Text = "Walk Speed",
    Min = 16,
    Max = 100,
    Default = 16,
    Callback = function(value)
        -- Your code here
    end,
})
```

Change the value:

```lua
Slider:Set(50)
```

---

## 📋 Add a Dropdown

```lua
local Dropdown = Main:AddDropdown({
    Options = {
        "Option 1",
        "Option 2",
        "Option 3"
    },
    Default = "Option 1",
    Callback = function(selected)
        -- Your code here
    end,
})
```

Select a different option:

```lua
Dropdown:Set("Option 2")
```

---

## 🔔 Add a Notification

```lua
Main:AddNotification({
    Text = "Loaded successfully!",
    Type = "success",
})
```

Available types:

- `info`
- `success`
- `warning`
- `error`

---

## ⌨️ Add a Keybind

```lua
local Keybind = Main:AddKeybind({
    Text = "Menu Key",
    Key = Enum.KeyCode.RightShift,
    Callback = function(key)
        -- Your code here
    end,
})
```

Read the current key:

```lua
print(Keybind:Get())
```]]
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
