local function copyCoordinates (object1, object2)
  object2.x = object1.x
  object2.y = object1.y
end

return {
  copyCoordinates = copyCoordinates
}
