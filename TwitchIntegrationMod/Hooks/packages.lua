if Global.load_level then
	local packages = {"levels/instances/unique/hlm_random_right003/world",
	"levels/instances/unique/hlm_gate_base/world","levels/instances/unique/hlm_door_wooden_white_green/world",
	"levels/instances/unique/hlm_reader/world",
	"levels/instances/unique/hlm_vault/world",
	"levels/instances/unique/hlm_box_contraband001/world",
	"levels/instances/unique/hox_fbi_armory/world",
	"levels/instances/unique/mus_security_barrier/world",
	"levels/instances/unique/san_box_tree001/world",
	"levels/narratives/vlad/ukrainian_job/world_sounds",
	"levels/narratives/vlad/jewelry_store/world_sounds",
	"levels/narratives/e_election_day/stage_3/world/world"} 
	for i = 1, #packages, 1 do
		if not PackageManager:loaded() then
			PackageManager:load(packages[i])
		end
	end
end
