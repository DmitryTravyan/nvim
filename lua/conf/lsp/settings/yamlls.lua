local config = require('yaml-companion').setup({
	-- Built in file matchers
	builtin_matchers = {
		-- Detects Kubernetes files based on content
		kubernetes = { enabled = true },
		cloud_init = { enabled = true },
	},

	-- Additional schemas available in Telescope picker
	schemas = {
		-- alacritty config
		{
			name = 'alacritty',
			uri = 'https://raw.githubusercontent.com/DmitryTravyan/alacritty/master/schema/reference.json',
		},
		-- ansible config
		-- {
		-- 	name = 'ansible_inventory',
		-- 	uri = 'https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/inventory.json',
		-- },
		-- {
		-- 	name = 'ansible_tasks',
		-- 	uri = 'https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks',
		-- },
		-- {
		-- 	name = 'ansible_playbooks',
		-- 	uri = 'https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook',
		-- },
		-- {
		-- 	name = 'gitlab-ci',
		-- 	url = 'https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json',
		-- },
	},

	-- Pass any additional options that will be merged in the final LSP config
	lspconfig = {
		flags = {
			debounce_text_changes = 150,
		},
		settings = {
			yaml = {
				validate = true,
				format = { enable = true },
				hover = true,
				schemaStore = {
					enable = true,
					url = 'https://www.schemastore.org/api/json/catalog.json',
				},
				schemaDownload = { enable = true },
				trace = { server = 'debug' },
			},
			redhat = {
				telemetry = {
					enabled = false,
				},
			},
		},
	},
})

return config
