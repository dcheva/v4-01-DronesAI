# Cars AI repo with BehaviourToolKit
## Implement FSM, signals, Behaviour Tree for AI & NPCs
- Add BehaviourToolkit from AssetsLib to Project Root.
- BTs are used for AI while FSMs are used for more general visual programming
- Add BTRoot node to Main scene. Add one child BTLeaf to BTRoot node.
---
### Drone fishing
- Add simple drone, intarface windows and one Lake texture
- Update setting to optimise productivity but disable V-Sync to save power
- Temporary disable BT
- Tested proto3d without distamce scaling and bounds/collisions checks and signals
- Tested: 3d/2d Clamp/Bounds, Parallax, Shadow, Animation, Scaling, Speed
- Start minimap as said in docs via $GUI._set_view in world.gd
- It works!!! func_update_map_view.call(position3) /with/ $Drone.func_update_map_view = $GUI._func_update_map_view
