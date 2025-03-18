-- Roblox Script Hub by Grok 3

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ScriptHub"
ScreenGui.Parent = game.StarterGui
ScreenGui.ResetOnSpawn = false

-- 主框架
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.4, 0, 0.6, 0)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- UI圆角
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- 标题栏
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, 0, 1, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Grok's Script Hub"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 20
TitleText.Font = Enum.Font.SourceSansBold
TitleText.Parent = TitleBar

-- 关闭按钮
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Parent = TitleBar

-- 功能按钮框架
local ButtonFrame = Instance.new("ScrollingFrame")
ButtonFrame.Size = UDim2.new(1, -20, 1, -50)
ButtonFrame.Position = UDim2.new(0, 10, 0, 45)
ButtonFrame.BackgroundTransparency = 1
ButtonFrame.ScrollBarThickness = 5
ButtonFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = ButtonFrame

-- 创建按钮函数
local function createButton(name, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 50)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 18
    Button.Font = Enum.Font.SourceSans
    Button.Parent = ButtonFrame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    
    -- 悬停效果
    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
end

-- 添加功能
createButton("超级速度", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
    print("超级速度已启用!")
end)

createButton("高跳", function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100
    print("高跳已启用!")
end)

createButton("无限跳跃", function()
    local player = game.Players.LocalPlayer
    local humanoid = player.Character:WaitForChild("Humanoid")
    humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
        humanoid.Jump = true
    end)
    print("无限跳跃已启用!")
end)

createButton("透视", function()
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 0.5
        end
    end
    print("透视已启用!")
end)

createButton("重置角色", function()
    game.Players.LocalPlayer.Character:BreakJoints()
    print("角色已重置!")
end)

-- 拖动功能
local dragging
local dragInput
local dragStart
local startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- 关闭按钮功能
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

-- 自适应屏幕大小
local function adjustForMobile()
    if game:GetService("UserInputService").TouchEnabled then
        MainFrame.Size = UDim2.new(0.8, 0, 0.7, 0)
        MainFrame.Position = UDim2.new(0.1, 0, 0.15, 0)
    end
end

adjustForMobile()

-- 开关按钮
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ToggleButton.Text = "打开"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Parent = ScreenGui

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    ToggleButton.Text = MainFrame.Visible and "关闭" or "打开"
end)

print("Script Hub 已加载!")