local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Teams = game:GetService("Teams")

-- Функция для поиска ближайшего игрока на другой команде
function findClosestPlayer()
  local closestPlayer = nil  -- Изначально ближайший игрок — это никто
  local closestDistance = math.huge -- Наибольшее возможное расстояние

  for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer and player.Team ~= nil then  -- Пропускаем себя и тех у кого нет команды
      -- Ключевой момент! Проверяем, есть ли у игрока персонаж и основная часть
      if player.Character and player.Character.PrimaryPart then
        local distance = (player.Character.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude  -- Вычисляем расстояние
        if player.Team ~= LocalPlayer.Team then -- Проверяем, что игрок на другой команде
          if distance < closestDistance then -- Если это игрок на другой команде и ближе, чем предыдущий
            closestDistance = distance  -- Обновляем расстояние
            closestPlayer = player  -- Запоминаем ближайшего игрока
          end
        end
      end
    end
  end

  return closestPlayer  -- Возвращаем найденного игрока
end

-- Ищем ближайшего игрока
local closestPlayer = findClosestPlayer()

if closestPlayer then
  local targetX = closestPlayer.Character.PrimaryPart.Position.X
  local targetY = closestPlayer.Character.PrimaryPart.Position.Y
  local targetZ = closestPlayer.Character.PrimaryPart.Position.Z

  -- Важно! Проверяем, есть ли у нашего игрока персонаж и корневой объект
  if LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart then
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetX, targetY +10, targetZ)
		print("Перемещен к ближайшему игроку")
  end
end
