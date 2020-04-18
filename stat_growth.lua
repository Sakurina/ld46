-- Stat Growth

StatGrowth = Object:extend()

function StatGrowth:new(stat, base_delta, critical_delta)
    self.impacted_stat = stat
    self.base_delta = base_delta
    self.critical_delta = critical_delta
    self.outcome = nil
end

function StatGrowth:roll(luck)
    local rng = lume.random(0, 1)
    if (rng <= luck) then
        self.outcome = self.critical_delta
    else
        self.outcome = self.base_delta
    end
end