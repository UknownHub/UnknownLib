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
    Text = "Your text here",
    Callback = function()
        -- Your code here
    end,
})
```

---

## ✅ Add a Toggle

```lua
local Toggle = Main:AddToggle({
    Text = "Your text here",
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
    Text = "Your text here",
    Min = 1,
    Max = 100,
    Default = 1,
    Callback = function(value)
        -- Your code here
    end,
})
```

Change the value:

```lua
Slider:Set(1)
```

---

## 📋 Add a Dropdown

```lua
local Dropdown = Main:AddDropdown({
    Options = {
        "Text 1",
        "Text 2",
        "Text 3"
    },
    Default = "Text 1",
    Callback = function(selected)
        -- Your code here
    end,
})
```

Select a different option:

```lua
Dropdown:Set("Text 2")
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
    Text = "Your text here",
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

# 🎉 That's it!

You're now ready to build interfaces with **UnknownLib**.
Simply create a window, add tabs, and start placing components with your own logic inside:

```lua
-- Your code here
```
````
