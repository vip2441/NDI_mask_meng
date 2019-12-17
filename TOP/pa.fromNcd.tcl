
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name MaskMeng -dir "R:/Users/Blo/Downloads/MaskMeng/planAhead_run_1" -part xc3s200ft256-4
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "R:/Users/Blo/Downloads/MaskMeng/top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {R:/Users/Blo/Downloads/MaskMeng} }
set_property target_constrs_file "top.ucf" [current_fileset -constrset]
add_files [list {top.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "R:/Users/Blo/Downloads/MaskMeng/top.ncd"
if {[catch {read_twx -name results_1 -file "R:/Users/Blo/Downloads/MaskMeng/top.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"R:/Users/Blo/Downloads/MaskMeng/top.twx\": $eInfo"
}
