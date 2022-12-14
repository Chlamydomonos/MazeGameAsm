__GAME_LOGIC_TOP_ASM__ macro
endm

.386
.model flat, stdcall
option casemap: none

include game_logic_top.inc
include game_logic_base.inc
include game_logic_middle.inc
include avl_tree.inc
include infinite_wfc.inc

.data
_out GameObjectDef <>
currentDefId dword 0
currentObjId dword 0
P_PLAYER0 byte "./player/player0.bmp", 0
P_PLAYER1 byte "./player/player1.bmp", 0
P_PLAYER2 byte "./player/player2.bmp", 0
P_PLAYER3 byte "./player/player3.bmp", 0
P_PLAYER4 byte "./player/player4.bmp", 0
P_PLAYER5 byte "./player/player5.bmp", 0
P_PLAYER6 byte "./player/player6.bmp", 0
P_PLAYER7 byte "./player/player7.bmp", 0
P_PLAYER8 byte "./player/player8.bmp", 0
P_PLAYER9 byte "./player/player9.bmp", 0
P_PLAYERa byte "./player/playerA.bmp", 0
P_PLAYERb byte "./player/playerB.bmp", 0
P_ENEMY0 byte "./enemy/enemy0.bmp", 0
P_ENEMY1 byte "./enemy/enemy1.bmp", 0
P_ENEMY2 byte "./enemy/enemy2.bmp", 0
P_ENEMY3 byte "./enemy/enemy3.bmp", 0
P_ENEMY4 byte "./enemy/enemy4.bmp", 0
P_ENEMY5 byte "./enemy/enemy5.bmp", 0
P_ENEMY6 byte "./enemy/enemy6.bmp", 0
P_ENEMY7 byte "./enemy/enemy7.bmp", 0
P_WALL byte "./map/wall.bmp", 0
P_GROUND byte "./map/ground.bmp", 0
P_TOWER0 byte "./tower/tower0.bmp", 0
P_TOWER1 byte "./tower/tower1.bmp", 0
P_BULLET byte "./map/bullet.bmp", 0
P_GATE byte "./map/gate.bmp", 0
P_COIN byte "./map/coin.bmp", 0
MIN_IJ sdword -896
MAX_IJ sdword 960

.code
initPlayer proc uses esi ecx
	mov eax, currentDefId
	mov _out.id, eax
	inc eax
	mov currentDefId, eax

	mov _out._width, 64
	mov _out.__height, 64
	mov _out.frameCount, 12
	new dword, 12
	mov _out.frameLengths, eax
	mov ecx, 0
	.while ecx < 12
		mov dword ptr [eax], 5
		add eax, sizeof dword
		inc ecx
	.endw
	new Bitmap, 12
	mov _out.frames, eax
	mov esi, eax

	invoke loadBitmap, addr P_PLAYER0, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_PLAYER1, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_PLAYER2, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_PLAYER3, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_PLAYER4, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_PLAYER5, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_PLAYER6, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_PLAYER7, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_PLAYER8, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_PLAYER9, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_PLAYERa, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_PLAYERb, 64, 64
	mov Bitmap ptr [esi], eax

	mov esi, offset _out
	return esi
initPlayer endp

initEnemy proc uses esi ecx
	mov eax, currentDefId
	mov _out.id, eax
	inc eax
	mov currentDefId, eax

	mov _out._width, 64
	mov _out.__height, 64
	mov _out.frameCount, 8
	new dword, 8
	mov _out.frameLengths, eax
	mov ecx, 0
	.while ecx < 8
		mov dword ptr [eax], 10
		add eax, sizeof dword
		inc ecx
	.endw
	new Bitmap, 8
	mov _out.frames, eax
	mov esi, eax

	invoke loadBitmap, addr P_ENEMY0, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_ENEMY1, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_ENEMY2, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_ENEMY3, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_ENEMY4, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_ENEMY5, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_ENEMY6, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_ENEMY7, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap

	mov esi, offset _out
	return esi
initEnemy endp

initWall proc uses esi
	mov eax, currentDefId
	mov _out.id, eax
	inc eax
	mov currentDefId, eax

	mov _out._width, 64
	mov _out.__height, 64
	mov _out.frameCount, 1
	new dword, 1
	mov _out.frameLengths, eax
	mov dword ptr [eax], 0
	new Bitmap, 1
	mov _out.frames, eax
	mov esi, eax

	invoke loadBitmap, addr P_WALL, 64, 64
	mov Bitmap ptr [esi], eax

	mov esi, offset _out
	return esi
initWall endp

initGround proc uses esi
	mov eax, currentDefId
	mov _out.id, eax
	inc eax
	mov currentDefId, eax

	mov _out._width, 64
	mov _out.__height, 64
	mov _out.frameCount, 1
	new dword, 1
	mov _out.frameLengths, eax
	mov dword ptr [eax], 0
	new Bitmap, 1
	mov _out.frames, eax
	mov esi, eax

	invoke loadBitmap, addr P_GROUND, 64, 64
	mov Bitmap ptr [esi], eax

	mov esi, offset _out
	return esi
initGround endp

initTower proc uses esi
	mov eax, currentDefId
	mov _out.id, eax
	inc eax
	mov currentDefId, eax

	mov _out._width, 64
	mov _out.__height, 64
	mov _out.frameCount, 2
	new dword, 2
	mov _out.frameLengths, eax

	mov dword ptr [eax], 0
	add eax, sizeof dword
	mov dword ptr [eax], 0

	new Bitmap, 2
	mov _out.frames, eax
	mov esi, eax

	invoke loadBitmap, addr P_TOWER0, 64, 64
	mov Bitmap ptr [esi], eax
	add esi, sizeof Bitmap
	invoke loadBitmap, addr P_TOWER1, 64, 64
	mov Bitmap ptr [esi], eax

	mov esi, offset _out
	return esi
initTower endp

initBullet proc uses esi
	mov eax, currentDefId
	mov _out.id, eax
	inc eax
	mov currentDefId, eax

	mov _out._width, 16
	mov _out.__height, 16
	mov _out.frameCount, 1
	new dword, 1
	mov _out.frameLengths, eax
	mov dword ptr [eax], 0
	new Bitmap, 1
	mov _out.frames, eax
	mov esi, eax

	invoke loadBitmap, addr P_BULLET, 16, 16
	mov Bitmap ptr [esi], eax

	mov esi, offset _out
	return esi
initBullet endp

initGate proc uses esi
	mov eax, currentDefId
	mov _out.id, eax
	inc eax
	mov currentDefId, eax

	mov _out._width, 64
	mov _out.__height, 64
	mov _out.frameCount, 1
	new dword, 1
	mov _out.frameLengths, eax
	mov dword ptr [eax], 0
	new Bitmap, 1
	mov _out.frames, eax
	mov esi, eax

	invoke loadBitmap, addr P_GATE, 64, 64
	mov Bitmap ptr [esi], eax

	mov esi, offset _out
	return esi
initGate endp

initCoin proc uses esi
	mov eax, currentDefId
	mov _out.id, eax
	inc eax
	mov currentDefId, eax

	mov _out._width, 64
	mov _out.__height, 64
	mov _out.frameCount, 1
	new dword, 1
	mov _out.frameLengths, eax
	mov dword ptr [eax], 0
	new Bitmap, 1
	mov _out.frames, eax
	mov esi, eax

	invoke loadBitmap, addr P_COIN, 64, 64
	mov Bitmap ptr [esi], eax

	mov esi, offset _out
	return esi
initCoin endp

createPlayer proc uses esi
	new	Player
	mov esi, eax

	mov eax, currentObjId
	mov (Player ptr [esi]).id, eax
	inc eax
	mov currentObjId, eax
	mov eax, offset objDefList.player
	mov (Player ptr[esi]).def, eax
	mov (Player ptr[esi]).coins, 0
	mov (Player ptr[esi]).currentFrame, 7
	mov (Player ptr[esi]).nextFrame, 7
	mov (Player ptr[esi]).hp, 500
	mov (Player ptr[esi]).level, 0
	mov (Player ptr[esi]).mapId, 0
	mov (Player ptr[esi]).moveStatus, MV_STILL
	mov (Player ptr[esi]).posX, 0
	mov (Player ptr[esi]).posY, 65
	mov (Player ptr[esi]).speed, 8
	mov (Player ptr[esi]).tick, 0
	mov (Player ptr[esi]).toBeDestroyed, false

	return esi

createPlayer endp

createEnemy proc uses ebx edx esi edi, posX: sdword, posY: sdword, hp: sdword, mapId: sdword
	new	Enemy
	mov esi, eax

	mov eax, currentObjId
	mov (Enemy ptr [esi]).id, eax
	inc eax
	mov currentObjId, eax
	mov eax, offset objDefList.enemy
	mov (Enemy ptr[esi]).def, eax
	mov eax, hp
	mov (Enemy ptr[esi]).hp, eax
	mov eax, mapId
	mov (Enemy ptr[esi]).mapId, eax
	mov eax, posX
	mov (Enemy ptr[esi]).posX, eax
	mov eax, posY
	mov (Enemy ptr[esi]).posY, eax
	mov (Enemy ptr[esi]).moveStatus, MV_STILL
	mov (Enemy ptr[esi]).currentFrame, 5
	mov (Enemy ptr[esi]).nextFrame, 4
	mov (Enemy ptr[esi]).tick, 0
	mov (Enemy ptr[esi]).toBeDestroyed, false
	
	invoke crt_rand 
	mov edx, 0
	mov ebx, 4
	div ebx
	mov eax, edx
	mov edi, GAME_INSTANCE.towers
	mov ebx, 4
	mul ebx
	add edi, eax
	mov eax, (Tower ptr [edi]).id
	mov (Enemy ptr [esi]).targetId, eax
	return esi
createEnemy endp

createTile proc uses esi, posX: sdword, posY: sdword, isWall: _bool
	new MapTile
	mov esi, eax

	mov eax, currentObjId
	mov (MapTile ptr[esi]).id, eax
	inc eax
	mov currentObjId, eax
	.if isWall
		mov (MapTile ptr[esi]).walkable, false
		mov eax, offset objDefList.wall
		mov (MapTile ptr[esi]).def, eax
	.else
		mov (MapTile ptr[esi]).walkable, true
		mov eax, offset objDefList.ground
		mov (MapTile ptr[esi]).def, eax
	.endif
	mov (MapTile ptr[esi]).currentFrame, 0
	mov (MapTile ptr[esi]).nextFrame, 0
	mov (MapTile ptr[esi]).tick, 0
	mov (MapTile ptr[esi]).toBeDestroyed, false
	mov eax, posX
	mov (MapTile ptr[esi]).posX, eax
	mov eax, posY
	mov (MapTile ptr[esi]).posY, eax

	return esi
createTile endp

createTower proc uses esi, posX: sdword, posY: sdword
	new Tower
	mov esi, eax

	mov eax, currentObjId
	mov (Tower ptr[esi]).id, eax
	inc eax
	mov currentObjId, eax

	mov eax, offset objDefList.tower
	mov (Tower ptr[esi]).def, eax
	mov (Tower ptr[esi]).currentFrame, 0
	mov (Tower ptr[esi]).nextFrame, 0
	mov (Tower ptr[esi]).tick, 0
	mov (Tower ptr[esi]).toBeDestroyed, false
	mov (Tower ptr[esi]).hp, 1000
	mov (Tower ptr[esi]).level, 0
	mov eax, posX
	mov (Tower ptr[esi]).posX, eax
	mov eax, posY
	mov (Tower ptr[esi]).posY, eax

	return esi
createTower endp

createBullet proc uses esi, posX: sdword, posY: sdword, velX: real8, velY: real8, damage: sdword
	new Bullet
	mov esi, eax

	mov eax, currentObjId
	mov (Bullet ptr[esi]).id, eax
	inc eax
	mov currentObjId, eax

	mov eax, offset objDefList.bullet
	mov (Bullet ptr[esi]).def, eax
	mov (Bullet ptr[esi]).currentFrame, 0
	mov (Bullet ptr[esi]).nextFrame, 0
	mov (Bullet ptr[esi]).tick, 0
	mov (Bullet ptr[esi]).toBeDestroyed, false
	mov eax, posX
	mov (Bullet ptr[esi]).posX, eax
	mov eax, posY
	mov (Bullet ptr[esi]).posY, eax
	fld velX
	fstp (Bullet ptr[esi]).velX
	fld velY
	fstp (Bullet ptr[esi]).velY
	mov eax, damage
	mov (Bullet ptr[esi]).damage, eax

	return esi
createBullet endp

createGate proc uses esi
	new MapTile
	mov esi, eax

	mov eax, currentObjId
	mov (MapTile ptr[esi]).id, eax
	inc eax
	mov currentObjId, eax

	mov (MapTile ptr[esi]).walkable, true
	mov eax, offset objDefList.gate
	mov (MapTile ptr[esi]).def, eax
	mov (MapTile ptr[esi]).currentFrame, 0
	mov (MapTile ptr[esi]).nextFrame, 0
	mov (MapTile ptr[esi]).tick, 0
	mov (MapTile ptr[esi]).toBeDestroyed, false
	mov (MapTile ptr[esi]).posX, 0
	mov (MapTile ptr[esi]).posY, 0

	return esi
createGate endp

createCoin proc uses esi, posX: sdword, posY: sdword
	new Destroyable
	mov esi, eax

	mov eax, currentObjId
	mov (Destroyable ptr[esi]).id, eax
	inc eax
	mov currentObjId, eax

	mov eax, offset objDefList.coin
	mov (Destroyable ptr[esi]).def, eax
	mov (Destroyable ptr[esi]).mapId, 1
	mov (Destroyable ptr[esi]).currentFrame, 0
	mov (Destroyable ptr[esi]).nextFrame, 0
	mov (Destroyable ptr[esi]).tick, 0
	mov (Destroyable ptr[esi]).hp, 1
	mov (Destroyable ptr[esi]).toBeDestroyed, false
	mov eax, posX
	mov (Destroyable ptr[esi]).posX, eax
	mov eax, posY
	mov (Destroyable ptr[esi]).posY, eax

	return esi
createCoin endp

initMap proc uses eax
	mov GAME_INSTANCE.ground.bulletsHead, nullptr
	mov GAME_INSTANCE.ground.bulletsEnd, nullptr
	mov GAME_INSTANCE.ground.destroyablesHead, nullptr
	mov GAME_INSTANCE.ground.destroyablesEnd, nullptr
	mov GAME_INSTANCE.ground.tilesHead, nullptr
	mov GAME_INSTANCE.ground.tilesEnd, nullptr
	invoke createTree
	mov GAME_INSTANCE.ground.tilesMap, eax

	mov GAME_INSTANCE.underground.bulletsHead, nullptr
	mov GAME_INSTANCE.underground.bulletsEnd, nullptr
	mov GAME_INSTANCE.underground.destroyablesHead, nullptr
	mov GAME_INSTANCE.underground.destroyablesEnd, nullptr
	mov GAME_INSTANCE.underground.tilesHead, nullptr
	mov GAME_INSTANCE.underground.tilesEnd, nullptr
	invoke createTree
	mov GAME_INSTANCE.underground.tilesMap, eax
	ret
initMap endp

createGround proc uses eax ebx ecx edx esi
	local   i:sdword,
			j:sdword
	mov eax, MIN_IJ
	mov i, eax
	.while eax < MAX_IJ
		mov eax, MIN_IJ
		mov j, eax
		.while eax < MAX_IJ
			.if (i == 0) && (j == 0)
				invoke createGate
			.else
				invoke createTile, i, j, false
			.endif
			mov esi, eax
			invoke addToMap, addr GAME_INSTANCE.ground, eax, T_TILE
			mov eax, i
			cdq
			mov ebx, 64
			idiv ebx
			mov ecx, eax
			and ecx, 0ffffh
			mov eax, j
			cdq
			mov ebx, 64
			idiv ebx
			shl eax, 16
			or eax, ecx
			invoke insert, GAME_INSTANCE.ground.tilesMap, eax, esi

			mov eax, j
			add eax, 64
			mov j, eax
		.endw
		mov eax, i
		add eax, 64
		mov i, eax
	.endw
	ret
createGround endp

createUnderground proc uses eax
	invoke createTree
	mov allBlocks, eax
	invoke genBlock, 0, 0, true
	ret
createUnderground endp

infiniteGenMap proc uses eax ebx edx, x: sdword, y: sdword
	local   x1:sdword,
			x2:sdword,
			y1:sdword,
			y2:sdword
	mov eax, x
	sar eax, 6
	mov x1, eax
	cdq
	mov ebx, 24
	idiv ebx
	mov x2, eax
	.if (x1 < 0) && (edx != 0)
		mov eax, x2
		dec eax
		mov x2, eax
	.endif
	mov eax, y
	sar eax, 6
	mov y1, eax
	cdq
	mov ebx, 24
	idiv ebx
	mov y2, eax
	.if (y1 < 0) && (edx != 0)
		mov eax, y2
		dec eax
		mov y2, eax
	.endif

	mov eax, x2
	mov ebx, y2
	invoke genBlock, eax, ebx, false
	mov eax, x2
	mov ebx, y2
	dec eax
	invoke genBlock, eax, ebx, false
	mov eax, x2
	mov ebx, y2
	dec ebx
	invoke genBlock, eax, ebx, false
	mov eax, x2
	mov ebx, y2
	inc eax
	invoke genBlock, eax, ebx, false
	mov eax, x2
	mov ebx, y2
	inc ebx
	invoke genBlock, eax, ebx, false
	mov eax, x2
	mov ebx, y2
	dec eax
	dec ebx
	invoke genBlock, eax, ebx, false
	mov eax, x2
	mov ebx, y2
	dec eax
	inc ebx
	invoke genBlock, eax, ebx, false
	mov eax, x2
	mov ebx, y2
	inc eax
	dec ebx
	invoke genBlock, eax, ebx, false
	mov eax, x2
	mov ebx, y2
	inc eax
	inc ebx
	invoke genBlock, eax, ebx, false
	ret
infiniteGenMap endp

addToMap proc uses eax ebx esi edi, map: dword, obj: dword, _type: ObjType
	new ListNode
	mov ebx, eax
	mov eax, obj
	mov (ListNode ptr [ebx]).value, eax
	mov (ListNode ptr [ebx]).next, nullptr
	mov esi, map
	.if _type == T_BULLET
		mov eax, (Map ptr [esi]).bulletsHead
		.if eax == nullptr
			mov (Map ptr [esi]).bulletsHead, ebx
			mov (Map ptr [esi]).bulletsEnd, ebx
		.else
			mov edi, (Map ptr [esi]).bulletsEnd
			mov (ListNode ptr [edi]).next, ebx
			mov (Map ptr [esi]).bulletsEnd, ebx
		.endif
	.elseif _type == T_DESTROYABLE
		mov eax, (Map ptr [esi]).destroyablesHead
		.if eax == nullptr
			mov (Map ptr [esi]).destroyablesHead, ebx
			mov (Map ptr [esi]).destroyablesEnd, ebx
		.else
			mov edi, (Map ptr [esi]).destroyablesEnd
			mov (ListNode ptr [edi]).next, ebx
			mov (Map ptr [esi]).destroyablesEnd, ebx
		.endif
	.elseif _type == T_TILE
		mov eax, (Map ptr [esi]).tilesHead
		.if eax == nullptr
			mov (Map ptr [esi]).tilesHead, ebx
			mov (Map ptr [esi]).tilesEnd, ebx
		.else
			mov edi, (Map ptr [esi]).tilesEnd
			mov (ListNode ptr [edi]).next, ebx
			mov (Map ptr [esi]).tilesEnd, ebx
		.endif
	.endif
	ret
addToMap endp

moveLogic proc uses ebx esi, obj: dword, velX: sdword, velY: sdword
	local   targetX:sdword,
			targetY:sdword,
			map:dword
	.if (velX == 0) && (velY == 0)
		return true
	.endif
	mov esi, obj
	mov eax, (Destroyable ptr [esi]).posX
	mov targetX, eax
	mov esi, (Destroyable ptr [esi]).def
	mov eax, (GameObjectDef ptr [esi])._width
	mov edx, 0
	mov ebx, 2
	div ebx
	add eax, targetX
	add eax, velX
	mov targetX, eax

	mov esi, obj
	mov eax, (Destroyable ptr [esi]).posY
	mov targetY, eax
	mov esi, (Destroyable ptr [esi]).def
	mov eax, (GameObjectDef ptr [esi]).__height
	mov edx, 0
	mov ebx, 2
	div ebx
	add eax, targetY
	add eax, velY
	mov targetY, eax

	mov esi, obj
	mov eax, (Destroyable ptr [esi]).mapId
	.if eax == 0
		mov eax, offset GAME_INSTANCE.ground
		mov map, eax
	.else
		mov eax, offset GAME_INSTANCE.underground
		mov map, eax
	.endif

	mov eax, targetX
	mov ebx, targetY
	sar eax, 6
	sar ebx, 6
	and eax, 0ffffh
	shl ebx, 16
	or eax, ebx
	mov esi, map
	invoke search, (Map ptr [esi]).tilesMap, eax
	.if eax == nullptr
		.if (velX == 0) || (velY == 0)
			return false
		.else
			invoke moveLogic, obj, velX, 0
			.if eax != false
				ret
			.endif
			invoke moveLogic, obj, 0, velY
			ret
		.endif
	.endif
	mov eax, (ListNode ptr [eax]).value
	mov al, (MapTile ptr [eax]).walkable
	.if al == false
		.if (velX == 0) || (velY == 0)
			return false
		.else
			invoke moveLogic, obj, velX, 0
			.if eax != false
				ret
			.endif
			invoke moveLogic, obj, 0, velY
			ret
		.endif
	.endif
	mov esi, obj
	mov eax, (Destroyable ptr [esi]).posX
	add eax, velX
	mov (Destroyable ptr [esi]).posX, eax
	mov eax, (Destroyable ptr [esi]).posY
	add eax, velY
	mov (Destroyable ptr [esi]).posY, eax
	return true
moveLogic endp

playerLogic proc uses eax ebx ecx edx esi edi
	local   map:dword,
			frame:dword,
			nextFrame:dword
	mov esi, GAME_INSTANCE.player
	mov eax, (Player ptr [esi]).mapId
	.if eax == 0
		mov eax, offset GAME_INSTANCE.ground
	.else
		mov eax, offset GAME_INSTANCE.underground
	.endif
	mov map, eax
	mov eax, (Player ptr [esi]).posX
	mov ebx, (Player ptr [esi]).posY
	sar eax, 6
	sar ebx, 6
	and eax, 0ffffh
	shl ebx, 16
	or eax, ebx
	mov edi, map
	invoke search, (Map ptr [edi]).tilesMap, eax
	.if eax != nullptr
		mov edi, eax
		mov edi, (ListNode ptr [edi]).value
		mov edi, (GameObject ptr [edi]).def
		mov edi, (GameObjectDef ptr [edi]).id
		.if edi == objDefList.gate.id
			mov eax, (Player ptr [esi]).posX
			mov ebx, (Player ptr [esi]).posY
			add eax, 32
			add ebx, 32
			.if (eax > 8) && (eax < 56) && (ebx > 8) && (ebx < 56)
				invoke changeMap
				ret
			.endif
		.endif
	.endif

	mov eax, (Player ptr [esi]).currentFrame
	mov frame, eax
	mov eax, (Player ptr [esi]).nextFrame
	mov nextFrame, eax

	mov eax, (Player ptr [esi]).mapId
	.if eax == 1
		invoke infiniteGenMap, (Player ptr [esi]).posX, (Player ptr [esi]).posY
	.endif
	mov ecx, (Player ptr [esi]).tick
	mov eax, (Player ptr [esi]).currentFrame
	mov edx, 0
	mov ebx, sizeof dword
	mul ebx
	mov edi, (Player ptr [esi]).def
	mov edi, (GameObjectDef ptr [edi]).frameLengths
	add edi, eax
	mov eax, ecx
	mov edx, 0
	mov ebx, dword ptr [edi]
	div ebx
	.if edx == 0
		mov eax, (Player ptr [esi]).moveStatus
		.if eax == MV_STILL
			.if frame <= 2
				mov (Player ptr [esi]).currentFrame, 1
				mov (Player ptr [esi]).nextFrame, 1
			.elseif frame <= 5
				mov (Player ptr [esi]).currentFrame, 4
				mov (Player ptr [esi]).nextFrame, 4
			.elseif frame <= 8
				mov (Player ptr [esi]).currentFrame, 7
				mov (Player ptr [esi]).nextFrame, 7
			.else
				mov (Player ptr [esi]).currentFrame, 10
				mov (Player ptr [esi]).nextFrame, 10
			.endif
		.else
			mov eax, nextFrame
			mov (Player ptr [esi]).currentFrame, eax
			.if eax > frame
				mov eax, nextFrame
				mov edx, 0
				mov ebx, 3
				div ebx
				.if edx == 1
					mov eax, (Player ptr [esi]).nextFrame
					inc eax
					mov (Player ptr [esi]).nextFrame, eax
				.else
					mov eax, (Player ptr [esi]).nextFrame
					dec eax
					mov (Player ptr [esi]).nextFrame, eax
				.endif
			.else
				mov eax, nextFrame
				mov edx, 0
				mov ebx, 3
				div ebx
				.if edx == 1
					mov eax, (Player ptr [esi]).nextFrame
					dec eax
					mov (Player ptr [esi]).nextFrame, eax
				.else
					mov eax, (Player ptr [esi]).nextFrame
					inc eax
					mov (Player ptr [esi]).nextFrame, eax
				.endif
			.endif

			mov eax, (Player ptr [esi]).moveStatus
			.if eax == MV_UP
				mov eax, frame
				mov edx, 0
				mov ebx, 3
				div ebx
				.if eax != 0
					mov (Player ptr [esi]).currentFrame, 1
					mov (Player ptr [esi]).nextFrame, 2
				.endif
			.endif

			mov eax, (Player ptr [esi]).moveStatus
			.if eax == MV_LEFT
				mov eax, frame
				mov edx, 0
				mov ebx, 3
				div ebx
				.if eax != 1
					mov (Player ptr [esi]).currentFrame, 1
					mov (Player ptr [esi]).nextFrame, 2
				.endif
			.endif

			mov eax, (Player ptr [esi]).moveStatus
			.if eax == MV_DOWN
				mov eax, frame
				mov edx, 0
				mov ebx, 3
				div ebx
				.if eax != 2
					mov (Player ptr [esi]).currentFrame, 1
					mov (Player ptr [esi]).nextFrame, 2
				.endif
			.endif

			mov eax, (Player ptr [esi]).moveStatus
			.if eax == MV_RIGHT
				mov eax, frame
				mov edx, 0
				mov ebx, 3
				div ebx
				.if eax != 3
					mov (Player ptr [esi]).currentFrame, 1
					mov (Player ptr [esi]).nextFrame, 2
				.endif
			.endif
		.endif
	.endif

	mov eax, 0
	mov ebx, 0
	.if controller.wDown != false
		sub ebx, (Player ptr [esi]).speed
	.endif
	.if controller.aDown != false
		sub eax, (Player ptr [esi]).speed
	.endif
	.if controller.sDown != false
		add ebx, (Player ptr [esi]).speed
	.endif
	.if controller.dDown != false
		add eax, (Player ptr [esi]).speed
	.endif
	invoke moveLogic, esi, eax, ebx

	.if (controller.aDown != false) && (controller.dDown == false)
		mov (Player ptr [esi]).moveStatus, MV_LEFT
	.elseif (controller.dDown != false) && (controller.aDown == false)
		mov (Player ptr [esi]).moveStatus, MV_RIGHT
	.elseif (controller.wDown != false) && (controller.sDown == false)
		mov (Player ptr [esi]).moveStatus, MV_UP
	.elseif (controller.sDown != false) && (controller.wDown == false)
		mov (Player ptr [esi]).moveStatus, MV_DOWN
	.else
		mov (Player ptr [esi]).moveStatus, MV_STILL
	.endif
	invoke playerAttackLogic
	ret
playerLogic endp

enemyLogic proc uses eax ebx ecx edx esi edi, enemy: dword
	local   frame:dword,
			nextFrame:dword,
			__hp:sdword
	mov esi, enemy
	mov frame, (Enemy ptr [esi]).currentFrame
	mov nextFrame, (Enemy ptr [esi]).nextFrame

	mov ecx, (Enemy ptr [esi]).tick
	mov eax, (Enemy ptr [esi]).currentFrame
	mov edx, 0
	mov ebx, sizeof dword
	mul ebx
	mov edi, (Enemy ptr [esi]).def
	mov edi, (GameObjectDef ptr [edi]).frameLengths
	add edi, eax
	mov eax, ecx
	mov edx, 0
	mov ebx, dword ptr [edi]
	div ebx
	.if edx == 0
		mov eax, nextFrame
		mov (Enemy ptr [esi]).currentFrame, eax
		mov eax, frame
		mov (Enemy ptr [esi]).nextFrame, eax

		mov eax, (Enemy ptr [esi]).currentFrame
		mov edx, 0
		mov edx, 2
		div edx
		mov edx, eax
		mov eax, (Enemy ptr [esi]).moveStatus
		.if (eax == MV_UP) && (edx != 0)
			mov (Enemy ptr [esi]).currentFrame, 0
			mov (Enemy ptr [esi]).nextFrame, 1
		.endif
		.if (eax == MV_LEFT) && (edx != 1)
			mov (Enemy ptr [esi]).currentFrame, 2
			mov (Enemy ptr [esi]).nextFrame, 3
		.endif
		.if (eax == MV_DOWN) && (edx != 2)
			mov (Enemy ptr [esi]).currentFrame, 4
			mov (Enemy ptr [esi]).nextFrame, 5
		.endif
		.if (eax == MV_RIGHT) && (edx != 3)
			mov (Enemy ptr [esi]).currentFrame, 6
			mov (Enemy ptr [esi]).nextFrame, 7
		.endif
	.endif

	mov eax, (Enemy ptr [esi]).hp
	mov __hp, eax
	.if __hp <= 0
		mov (Enemy ptr [esi]).toBeDestroyed, true
		mov eax, (Enemy ptr [esi]).mapId
		.if eax == 1
			mov eax, GAME_INSTANCE.score
			inc eax
			mov GAME_INSTANCE.score, eax
		.endif
	.endif
	ret
enemyLogic endp

playerAttackLogic proc
	ret
playerAttackLogic endp

towerLogic proc, tower: dword
	ret
towerLogic endp

bulletLogic proc, mapId: sdword, bullet: dword
	ret
bulletLogic endp

coinLogic proc, coin: dword
	ret
coinLogic endp

upgradeLogic proc
	ret
upgradeLogic endp

genEnemy proc uses eax ebx ecx edx
	local   enemyAmount:dword,
			enemyHp:dword,
			edgeId:dword,
			pos:sdword
	mov eax, GAME_INSTANCE.globalTick
	mov edx, 0
	mov ebx, 720
	div ebx
	inc eax
	mov enemyAmount, eax
	mov eax, GAME_INSTANCE.globalTick
	mov edx, 0
	mov ebx, 9
	div ebx
	add eax, 100
	mov enemyHp, eax
	mov ecx, 0
	.while ecx < enemyAmount
		invoke crt_rand
		mov edx, 0
		mov ebx, 4
		div ebx
		mov edgeId, edx
		invoke crt_rand
		mov edx, 0
		mov ebx, 1800
		div ebx
		sub edx, 900
		mov pos, edx
		.if edgeId == 0
			invoke createEnemy, -900, pos, enemyHp, 0
		.elseif edgeId == 1
			invoke createEnemy, pos, -900, enemyHp, 0
		.elseif edgeId == 2
			invoke createEnemy, 900, pos, enemyHp, 0
		.elseif edgeId == 3
			invoke createEnemy, pos, 900, enemyHp, 0
		.endif
		invoke addToMap, addr GAME_INSTANCE.ground, eax, T_DESTROYABLE
		inc ecx
	.endw
	ret
genEnemy endp

changeMap proc uses eax ebx ecx esi edi
	local temp:dword
	new Player
	mov edi, eax
	mov temp, eax
	mov ebx, sizeof Player
	mov ecx, 0
	mov esi, GAME_INSTANCE.player
	.while ecx < ebx
		mov al, byte ptr [esi]
		mov byte ptr [edi], al
		inc esi
		inc edi
		inc ecx
	.endw
	mov esi, GAME_INSTANCE.player
	mov (Player ptr [esi]).toBeDestroyed, true
	mov edi, temp
	mov eax, (Player ptr [edi]).mapId
	.if eax == 0
		mov (Player ptr [edi]).mapId, 1
		invoke addToMap, addr GAME_INSTANCE.underground, temp, T_DESTROYABLE
		mov GAME_INSTANCE.playerOnGround, false
	.else
		mov (Player ptr [edi]).mapId, 0
		invoke addToMap, addr GAME_INSTANCE.ground, temp, T_DESTROYABLE
		mov GAME_INSTANCE.playerOnGround, true
	.endif
	mov GAME_INSTANCE.player, edi
	mov (Player ptr [edi]).posX, 0
	mov (Player ptr [edi]).posY, 128
	ret
changeMap endp

end