local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
-- 拉布布
local processed = {}

local function isCharacterPart(part)
    local model = part:FindFirstAncestorOfClass("Model")
    return model and model:FindFirstChildOfClass("Humanoid")
end
-- 玉米程式
local function optimize(obj)
    if processed[obj] then return end
    processed[obj] = true
    
    if obj:IsA("BasePart") and isCharacterPart(obj) then return end
    
    if obj:IsA("BasePart") then
        obj.Material = Enum.Material.Plastic
        obj.Reflectance = 0
        obj.CastShadow = false
    end
    
    if obj:IsA("Decal")
    or obj:IsA("Texture")
    or obj:IsA("ParticleEmitter")
    or obj:IsA("Trail")
    or obj:IsA("Beam")
    or obj:IsA("Smoke")
    or obj:IsA("Fire")
    or obj:IsA("Sparkles") then
        obj:Destroy()
        return
    end
    
    if obj:IsA("PointLight")
    or obj:IsA("SpotLight")
    or obj:IsA("SurfaceLight") then
        obj.Enabled = false
    end
end

for _,v in ipairs(workspace:GetDescendants()) do
    optimize(v)
end

workspace.DescendantAdded:Connect(optimize)

Lighting.GlobalShadows = false
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0
Lighting.FogEnd = 9e9

local terrain = workspace:FindFirstChildOfClass("Terrain")
if terrain then
    terrain.WaterWaveSize = 0
    terrain.WaterWaveSpeed = 0
    terrain.WaterReflectance = 0
    terrain.WaterTransparency = 1
end
