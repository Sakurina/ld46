StoryPrecondition = Object:extend()

function StoryPrecondition:new(stat, compare_type, threshold)
    self.stat = stat
    self.compare_type = compare_type
    self.threshold = threshold
end

function StoryPrecondition:evaluate(stats)
    if self.compare_type == ">=" then
        return stats[self.stat] >= self.threshold
    elseif self.compare_type == ">" then
        return stats[self.stat] > self.threshold
    elseif self.compare_type == "<=" then
        return stats[self.stat] <= self.threshold
    elseif self.compare_type == "<" then
        return stats[self.stat] < self.threshold
    elseif self.compare_type == "==" then
        return stats[self.stat] == self.threshold
    elseif self.compare_type == "!=" then
        return stats[self.stat] ~= self.threshold
    end
    return false
end