🌠 UnknownLib

A lightweight Roblox UI library focused on simplicity, performance, and clean design.

📦 Installation

Import the latest version of UnknownLib:

local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/UknownHub/UnknownLib/refs/heads/main/UnknownLib.lua"))()

---

🪟 Create a Window

local Window = Lib:CreateWindow({
    Title = "Your text here",
    ToggleKey = Enum.KeyCode.RightShift,
})

Parameter| Type| Description
"Title"| "string"| Text shown in the title bar.
"ToggleKey"| "Enum.KeyCode"| Key used to show or hide the interface.

---

📁 Add a Tab

local Main = Window:AddTab("Your text here")

---

📌 Add a Section

Main:AddSection("Your text here")

---

🔘 Add a Button

Main:AddButton({
    Text = "Your text here",
    Callback = function()
        -- Your code here
    end,
})

---

✅ Add a Toggle

local Toggle = Main:AddToggle({
    Text = "Your text here",
    Default = false,
    Callback = function(state)
        -- Your code here
    end,
})

Update it later:

Toggle:Set(true)

---

🎚️ Add a Slider

local Slider = Main:AddSlider({
    Text = "Your text here",
    Min = 1,
    Max = 100,
    Default = 1,
    Callback = function(value)
        -- Your code here
    end,
})

Update it later:

Slider:Set(50)

---

📋 Add a Dropdown

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

Update it later:

Dropdown:Set("Option 2")

---

🎨 Add a Colorpicker

local Colorpicker = Main:AddColorpicker({
    Text = "Choose Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        -- Your code here
    end,
})

Update it later:

Colorpicker:Set(Color3.fromRGB(0, 255, 0))

---

📝 Add an Input

local Input = Main:AddInput({
    Text = "Your text here",
    Placeholder = "Type something...",
    Callback = function(value)
        -- Your code here
    end,
})

Update it later:

Input:Set("Hello World")

---

⌨️ Add a Keybind

local Keybind = Main:AddKeybind({
    Text = "Your text here",
    Key = Enum.KeyCode.RightShift,
    Callback = function(key)
        -- Your code here
    end,
})

Read the current key:

print(Keybind:Get())

---

📄 Add a Paragraph

Main:AddParagraph({
    Title = "Information",
    Content = "Your paragraph text here."
})

---

💻 Add a Code Block

Main:AddCode({
    Title = "Example",
    Code = [[
print("Hello, UnknownLib!")
    ]]
})

---

📦 Add a Group

local Group = Main:AddGroup("Settings")

Use the returned group to organize related UI elements.

---

➖ Add a Divider

Main:AddDivider()

---

📏 Add a Space

Main:AddSpace()

---

🖼️ Add an Image

Main:AddImage({
    Image = "rbxassetid://1234567890"
})

---

🎥 Add a Video

Main:AddVideo({
    Video = "your_video_source"
})

---

🔊 Add Audio

Main:AddAudio({
    Audio = "rbxassetid://1234567890",
    Autoplay = true
})

---

🔔 Add a Notification

Main:AddNotification({
    Text = "Loaded successfully!",
    Type = "success",
})

Available notification types:

- "info"
- "success"
- "warning"
- "error"

---

🎉 That's it!

You're now ready to build interfaces with UnknownLib. Create a window, add tabs and sections, then use buttons, toggles, sliders, dropdowns, color pickers, inputs, keybinds, paragraphs, code blocks, groups, dividers, spaces, images, videos, audio, and notifications to build your UI.
