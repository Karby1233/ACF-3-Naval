local ACF       = ACF
local Classes 	= ACF.Classes

Classes.DefineClass("ACF.Missiles.Guidance.Acoustic", "ACF.Missiles.Guidance.Infrared", function(CLASS)
	CLASS.Name = "Acoustic"
	if CLIENT then
		CLASS.Description = "This guidance package will detect a sound infront of it and guide itself torwards it."
	else
		function CLASS:GetCost()
			return 2
		end

		--write a function here that returns the calculated position below the water. You're gonna use a trace for this. Call it in the update target function
		function DepthCalculation(EntPos)
		local tr = util.TraceLine({
			start = EntPos + Vector(0,0,5000),
			endpos = EntPos - Vector(0,0,10000),
			filter = {"acf_*", "prop_*"},
			mask = bit.bor(MASK_WATER)
		})

		return tr.HitPos.z - 50 //this will be the torpedoes depth limit later

		end

		function CLASS:UpdateTarget(Missile)
			local Position   = Missile.ACF_Position
			local Targets    = ACF.GetEntitiesInCone(Position, Missile:GetForward(), self.SeekCone)
			local HighestDot = 0
			local Target, TargetPos

			for Entity in pairs(Targets) do
				local EntPos   = Vector(Entity.ACF_Position.x, Entity.ACF_Position.y, math.Clamp(Entity.ACF_Position.z, Entity.ACF_Position.z,DepthCalculation(Entity.ACF_Position)))

				local Distance = Position:DistToSqr(EntPos)

				if Distance < self.MinDistance then continue end
				if not self:CheckConeLOS(Missile, Position, EntPos, self.SeekConeCos) then continue end

				local CurrentDot = self.GetDirectionDot(Missile, EntPos)

				if CurrentDot > HighestDot then
					HighestDot = CurrentDot
					TargetPos  = EntPos
					
					Target     = Entity
				end
			end

			self.Target = Target

			return TargetPos
		end

		function CLASS:GetTargetPosition()
			local Target = self.Target

			if not IsValid(Target) then return end




			return Vector(Target.ACF_Position.x, Target.ACF_Position.y, math.Clamp(Target.ACF_Position.z, Target.ACF_Position.z,DepthCalculation(Target.ACF_Position)))
		end

		function CLASS:GetGuidance(Missile)
			self:PreGuidance(Missile)

			local Override = self:ApplyOverride(Missile)

			if Override then return Override end

			local TargetPos = self:GetTargetPosition()

			if TargetPos and self:CheckConeLOS(Missile, Missile.ACF_Position, TargetPos, self.ViewConeCos) then
				return { TargetPos = TargetPos, ViewCone = self.ViewCone }
			end

			local NewTarget = self:UpdateTarget(Missile)

			if not NewTarget then return {} end

			return { TargetPos = NewTarget, ViewCone = self.ViewCone }
		end
	end
end)