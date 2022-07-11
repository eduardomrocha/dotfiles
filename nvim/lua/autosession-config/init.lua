require("auto-session").setup({
	log_level = "info",
	auto_session_root = { "~/sessions" },
	auto_session_enabled = false,
	auto_session_create_enabled = false,
	auto_save_enabled = true,
	auto_session_use_git_branch = true,
})
