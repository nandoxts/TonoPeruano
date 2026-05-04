--[[                                           <<DO NOT DELETE THIS MODULE>>
   ___      _______                _     
  / _ |____/ ___/ /  ___ ____ ___ (_)__ 
 / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
/_/ |_|   \___/_//_/\_,_/___/___/_/___/	Build 6.52S2
				SecondLogic @ Inspare

>>Manual

Basically...everything you can and would ever want to touch is in the tuning module. EVERYTHING

Torque Curve Tune Visualizer:
https://www.desmos.com/calculator/2uo3hqwdhf


Basic Tips:
--Installation
	>Everything is built-in (assembly, welding, suspension, gyros), so all you have to worry about is placing the wheels and the seat.
	>Body parts go in the "Body" section.
	>Wheel parts such as 3D rims and brake disks go in the "Parts" section of the wheel.
	>Suspension-Anchored parts such as suspension wishbones and linkages go in the "SuspensionFixed" section.
	>Axle-Anchored parts such as calipers go in the "WheelFixed" section.
	>You can add or remove wheels. To add a wheel, simply copy one of the wheels and make sure it's named one of the following: "F","FL","FR","R","RL","RR".
	>Wheels need to be aligned with the axes of the seat. Don't rotate the seat relative to the wheels as it may cause welding problems.
	>All wheel offsets are applied in the tuning module. Do NOT manually add offset to the wheels. Steering axis is centered on the wheel part by default.
	>Seat offset can be adjusted in the "MiscWeld" module under "Initialize".
	>Use the "Misc" section for scripted/moving parts and apply welding using the "MiscWeld" module under "Initialize".

--Tuning
	>Reduce weight(density) if setup is lacking torque. Increase density if setup has too much torque.
	>Add downforce manually if setup is lacking grip or use a downforce plugin.
	>Dialing in ratios used in real cars is an easy way to have a realisticly tuned transmission.
	>Modifying the "Drive" script may affect the integrity of the system.
	>Custom scripts should be put in the "Plugins" folder. Using plugins made by other users is encouraged.
	>When writing custom plugins, you can reference the values within the "Values" folder inside the A-Chassis Interface.
	>It is a good practice to make plugins compatible with any setup and providing a usage manual if a plugin is released.
	>You can remove/change the default plugins that come with the kit. The drive system will still work perfectly with or without them.
	
--Updates
	>To update, simply just replace the entire "A-Chassis Tune" module of an existing car with a newer version of the module.
	>You may want to copy the tune values and plugins from the old module, but dont simply overwrite the tune module as new values may be added.
	

>>Changelog
	[6/10/17 : Build 6.52S2] - Fixed Initialization Orientation
		[Fixed Initialization Rotation]
		-Fixed initialization rotation glitch

	[6/8/17 : Build 6.51S2] - More Suspension Tuning
		[Re-Added Suspension Values]
		-New suspension tuning is now the same as the previous suspension
		-AntiRoll and PreCompress are now added to suspension tuning
		
		[Fixes]
		-Fixed Rev-Boucing: Car does not stall anymore when rev-bouncing
		-Fixed Stock Gauges not showing the the right transmission mode / pbrake mode

	[6/8/17 : Build 6.5S2] - Full Suspension Change and Optimization
		[New Suspension System]
		-Suspension Linkages are now made using axles instead of constraints
		-Better overall stability and ease of tuning
		-SpringConstraint Tuning has been changed in the tune to more meaningful values
		-Added AntiRoll system using gyro dampening on the suspension linkages
		-AxleSize affects the size of suspension linkage parts
		
		[Major Performance Optimizations]
		-Torque output calculations are now cached (pre-calculated and stored) to reduce runtime cpu load
		-Constant multipliers for several lines have been simplified and cached
		-Split Engine function into RPM calculation and Power Output
		-Split runtime loops into different cycle rates
		-RPM calculation, Steering, and External Value updating now run on 60 FPS max (from 30) for smoother steering and RPM tracking.
		-Engine Output and Flip now run on 15 FPS max (from 30) to reduce runtime cpu load
		-Overall percieved smoothness is now TWICE AS MUCH but runtime cpu load has actually been HALVED!!!

	[5/23/17 : Build 6.43S] - STUFF
		[Added Tune Values]
		-Added WBVisible to set weight brick visibility
		
		[Independent Camera Handling]
		-Separated camera handling from Drive script
		-Mouse camera is now handled by a plugin
		-Custom camera plugin support is now easier
		
		[Stock Plugins Update]
		-Added Dynamic Friction as a stock plugin
		-Dynamic friction can be tuned within the Simulated script
		-Updated default sound plugin
		-Added mouse-steer camera plugin
		
		[Code Fixes]
		-Fixed missing operation within torque curve
		-Slight optimizations during runtime

	[5/20/17 : Build 6.42S] - ABS and PGS Standardization
	
		[Added ABS]
		-Modulates brakes when locking
		-Added threshold value for slip allowance
		-Added control toggles for ABS
		-Added ABS indicator and control mapping to stock UI
		
		[Split Density Tuning for PGS and Legacy]
		-Added standardized weight scaling values to tune
		-Default weight tuning set to 1 cubic stud : 50 lbs for PGS
		-Default weight tuning set to 1 cubic stud : 10 lbs for Legacy
		-Split front and rear density to PGS and Legacy
		-Split brake force tuning to PGS and Legacy
		
		[Added Tune Values]
		-TCSEnabled: Sets whether or not the car will have TCS
		-ABSEnabled: Sets whether or not the car will have ABS
		-LoadDelay: Sets a delay time before initializing car
		
		[Bug Fix: Axle Size Initialization]
		-Car applies proper axle size
		-Added AxleDensity value which sets axle density
		-Fixed miscelaneous wheel part welding
		
		[Added Changable Stock Gauge Units]
		-Added units system for stock gauges
		-Added default units: MPH [1 stud : 10 in], KP/H [1 stud : 10 in], SPS
		-Custom units can be added or removed
		-Click on speed to change between units
		-Moved Controls button to middle for better visibility
		
		[Code Documentation]
		-Extensive documentation and commenting within scripts for better readability
		-Improved warning message for oversized mass condition

	[5/4/17 : Build 6.41S] - Standardized Weight
	
		[Added automatic weight system]
		-Added tune values for car weight, center of gravity, and wheel density
		-Weight standard: 100 lbs = 1 cubic stud mass
		-Applies weight at initialization
		
		[Scaled Down Power Delivery]
		-Horsepower output now at 1/10 because of lighter weight standard
		-Added FDMult value in transmission for gear ratio scaling without having to change Final Drive (useful for low HP tunes)
		
		[Optimized value for Anchor Offset]
		-Changed "SusOffset" to "Anchor Offset"
		-New anchor offset is now based off of wishbone length and wishbone angle.
		-Anchor offset now labelled for forward, lateral, and vertical offsets.
		
		[Split some tune values to F/R]
		-Suspension values for front and rear are now independently tunable.
		-Front and rear brakes can be tuned independently.	
		
		[Tune Module Housekeeping]
		-Rearranged and documented several of the values within the tune module.
		-Removed GyroP and GyroMaxTorque for simplicity. Dampening values are still present.
		-Changed some decimal values to percent values 

	[1/2/17 : Build 6.40S] - Suspension
		"S" Build number identifies suspension build
	
		[Added suspension system for PGS Physics Solver]
		-Suspension uses ROBLOX constraints and is automatically generated with the chassis
		-Added tune values for suspension
		-Temporarily removed caster tuning
		
		[Steering Fix]
		-Added tune value 'ReturnSpeed' which determines how fast wheels return to default orientation
		
		[New Torque Curve Equation]
		-New equation gives more control over the shape of the torque curve
		-Engine values have been replaced with the new equation's variables
		-Added link to desmos graph for the torque curve visualization

	[10/31/16 : Build 6.33] - Semi-Automatic
		
		[Added semi-automatic transmission mode]
		-'TransModes' now accepts "Semi" value for semi-automatic.
		-Updated AC6_Stock_Gauges to include semi-automatic mode.
		
		[Fixed disengaging p-brake]
		-P-Brake now remains engaged if player gets into then vehicle.
		
		[Fixed FE Support for AC6_Stock_Sound]
		-Sounds should now work properly with Filtering Enabled.

	[8/5/16 : Build 6.32] - Differential System
		
		[Implemented differential system]
		-Differential controls torque distibution between wheels that are spinning at different rates
		-Added tune values 'FDiffSlipThres', 'FDiffLockThres', 'RDiffSlipThres', 'RDiffLockThres', 'CDiffSlipThres', and 'CDiffLockThres'.
		-'DiffSlipThres' determine the threshold of the speed difference between the wheels. Full lock applies at max threshold.
		-A lower slip threshold value will make the diff more aggressive.
		-'DiffLockThres' determines the bias of the differential.
		-A lock threshold value more than 50 puts more torque into the slipping wheel (moving towards an open diff).
		-A lock threshold value less than 50 puts more torque into the grounded wheel (moving towards a locked diff).
		
		[Fixed multiple wheel support]
		-The chassis can now use more than just the default 4 set of wheels. Just copy an existing wheel and place accordingly.
		-Differential works with auxiliary wheels.

	[7/13/16 : Build 6.31] - Peripheral Settings
		
		[Added peripheral adjustment values]
		-Moved controller and mouse deadzone values to the "Controls" section of the tune.
		-Split controller deadzone into left and right input.
		-Moved mouse control width to "Conrols" secton. This value now operates based off of % of screed width.
		
		[Updated stock Controls Module]
		-Added sliders for controller and mouse deadzone values.
		-Added slider for mouse control width.

	[6/15/16 : Build 6.3] - Motercisly
	
		[Better motorcycle system support]
		-Added wheel configurations "F" and "R" for single wheel settup.
		-"F" and "R" wheels will have axle parts on both sides for better balance.
		-These wheel configurations will ignore outor rotation value and will rotated based off of the inner rotation value only.
		-Camber and Toe cannot be applied to these wheel configurations. Caster will still be applied as normal.
		
		[Bug fixes]
		-Caster now applies after wheel part rotations so wheel parts dont rotate with caster.
		-Fixed Clutch re-engaging automatically when shifting out of neutral.	
		
	[4/6/16: Compilación 6.21] - Lanzamiento del kit público oficial AC6

[La compatibilidad habilitada para el filtrado de complementos es más fácil]
-El sistema ahora detecta si hay un RemoteEvent o RemoteFunction dentro de un complemento. Estos se colocarán directamente debajo del coche.
-RemoteEvent/RemoteFunction debe ser un elemento secundario directo del complemento para que pueda ser detectado.
-Los scripts dentro de RemoteEvent/RemoteFunction deben estar deshabilitados. Se habilitarán después de la inicialización.
-Tenga cuidado ya que este sistema es susceptible de provocar colisiones de nombres. Asigne un nombre exclusivo a sus RemoteEvents/RemoteFunctions.
-El complemento Stock AC6 Sound ahora es compatible con FE.

[El Panel de controles ahora es un complemento en lugar de estar integrado]
-Panel de controles separado del script de Drive. El panel de controles ahora es un complemento.
-La carpeta "Controles" aparece dentro de la interfaz al iniciar Drive. Utilice esta carpeta para hacer referencia a los valores de asignación de botones para complementos de controles personalizados.
-Valor añadido "ControlsOpen". Esta es una palanca de seguridad al cambiar los valores de control. Este valor puede ser manipulado mediante complementos.

[Nuevos valores de melodía]
-Se agregó el valor de melodía 'AutoFlip'. Esto determina si el automóvil se da vuelta automáticamente cuando está boca abajo.
-Se agregó el valor de sintonización 'StAxisOffset'. Esto compensa el centro del eje de dirección. Valor positivo = desplazamiento hacia afuera.
-Se agregaron los valores 'SteerD', 'SteerMaxTorque' y 'SteerP' que establecen las propiedades del giroscopio del eje de dirección.

[Racionalización de MiscWeld]
-Se agregó la sección "Varios" a las secciones principales. Esto debe contener partes escritas/móviles.
-Las piezas de esta sección NO ESTÁN SOLDADAS AUTOMÁTICAMENTE. Utilice el módulo "MiscWeld" para soldar estas piezas. La sección "Misc" tiene una referencia previa como "misc".

[Corrección de errores]
-Se corrigió que el giroscopio no se reiniciaba cuando el giroscopio estaba activo y el conductor abandonaba el auto.
-Se solucionó el problema con el cambio de modos de transmisión.
--]]

return "6.52S2"