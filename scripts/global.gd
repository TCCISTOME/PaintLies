extends Node

var player_life_max := 100
var player_life := 100
var player_attack := 100
var player_defese_max := 100  
var player_defese := 100

var countXp := 0
var countTimer := 0
var countPotion := 0

#Evita a colisão dupla
#await $hurtBox/collision.call_deferred("queue_free")
