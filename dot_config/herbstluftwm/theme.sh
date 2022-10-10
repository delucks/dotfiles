source "$HOME/.config/herbstluftwm/common.sh"

# base theme
#herbstclient attr theme.background_color
herbstclient attr theme.border_width							$_BORDER_WIDTH
herbstclient attr theme.color											$COLORBG
herbstclient attr theme.inner_color								$COLORBG
herbstclient attr theme.inner_width								$_INNER_WIDTH
#herbstclient attr theme.outer_color
#herbstclient attr theme.outer_width
#herbstclient attr theme.padding_bottom						0
#herbstclient attr theme.padding_top								0
#herbstclient attr theme.padding_left							0
#herbstclient attr theme.padding_right							0
log "Base styles set"

# selected window
herbstclient attr theme.active.reset 1
#herbstclient attr theme.active.background_color
herbstclient attr theme.active.border_width				$_BORDER_WIDTH
herbstclient attr theme.active.color							$COLOR1
herbstclient attr theme.active.inner_color				$COLORBG
#herbstclient attr theme.active.inner_width				0
#herbstclient attr theme.active.outer_color
#herbstclient attr theme.active.outer_width
#herbstclient attr theme.active.padding_bottom			0
#herbstclient attr theme.active.padding_top 				0
#herbstclient attr theme.active.padding_left				0
#herbstclient attr theme.active.padding_right			0
log "Active styles set"

# nonselected, nonurgent windows
herbstclient attr theme.normal.reset 1
#herbstclient attr theme.normal.background_color
herbstclient attr theme.normal.border_width				$_BORDER_WIDTH
herbstclient attr theme.normal.color							$COLOR0
herbstclient attr theme.normal.inner_color				$COLORBG
herbstclient attr theme.normal.inner_width				$_INNER_WIDTH
#herbstclient attr theme.normal.outer_color
#herbstclient attr theme.normal.outer_width
#herbstclient attr theme.normal.padding_bottom			0
#herbstclient attr theme.normal.padding_top				0
#herbstclient attr theme.normal.padding_left				0
#herbstclient attr theme.normal.padding_right			0
log "Non/non styles set"

# urgent windows
herbstclient attr theme.urgent.reset 1
#herbstclient attr theme.urgent.background_color
herbstclient attr theme.urgent.border_width				20
herbstclient attr theme.urgent.color							$COLOR7
herbstclient attr theme.urgent.inner_color				$COLORBG
herbstclient attr theme.urgent.inner_width				$_INNER_WIDTH
#herbstclient attr theme.urgent.outer_color
#herbstclient attr theme.urgent.outer_width
#herbstclient attr theme.urgent.padding_bottom			0
#herbstclient attr theme.urgent.padding_top				0
#herbstclient attr theme.urgent.padding_left				0
#herbstclient attr theme.urgent.padding_right			0
log "Urgent styles set"

# not sure
#herbstclient attr theme.minimal.reset 1
#herbstclient attr theme.minimal.background_color
#herbstclient attr theme.minimal.border_width
#herbstclient attr theme.minimal.color
#herbstclient attr theme.minimal.inner_color
#herbstclient attr theme.minimal.inner_width
#herbstclient attr theme.minimal.outer_color
#herbstclient attr theme.minimal.outer_width
#herbstclient attr theme.minimal.padding_bottom
#herbstclient attr theme.minimal.padding_top
#herbstclient attr theme.minimal.padding_left
#herbstclient attr theme.minimal.padding_right

# floating windows
#herbstclient attr theme.floating.reset 1
#herbstclient attr theme.floating.background_color
#herbstclient attr theme.floating.border_width
#herbstclient attr theme.floating.color
#herbstclient attr theme.floating.inner_color
#herbstclient attr theme.floating.inner_width
#herbstclient attr theme.floating.outer_color
#herbstclient attr theme.floating.outer_width
#herbstclient attr theme.floating.padding_bottom
#herbstclient attr theme.floating.padding_top
#herbstclient attr theme.floating.padding_left
#herbstclient attr theme.floating.padding_right

# tiling windows
#herbstclient attr theme.tiling.reset 1
#herbstclient attr theme.tiling.background_color
#herbstclient attr theme.tiling.border_width
#herbstclient attr theme.tiling.color
#herbstclient attr theme.tiling.inner_color
#herbstclient attr theme.tiling.inner_width
#herbstclient attr theme.tiling.outer_color
#herbstclient attr theme.tiling.outer_width
#herbstclient attr theme.tiling.padding_bottom
#herbstclient attr theme.tiling.padding_top
#herbstclient attr theme.tiling.padding_left
#herbstclient attr theme.tiling.padding_right

# frames
herbstclient attr settings.frame_border_normal_color $COLORBG
herbstclient attr settings.frame_border_active_color $COLORBG
herbstclient attr settings.frame_border_width 0
herbstclient attr settings.frame_bg_normal_color $COLORBG
herbstclient attr settings.frame_bg_active_color $COLORBG
herbstclient attr settings.frame_bg_transparent 1

log "Frames styles set"
