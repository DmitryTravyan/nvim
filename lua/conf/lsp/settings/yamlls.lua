return {
	redhat = {
		telemetry = {
			enabled = false,
		},
	},
	settings = {
		yaml = {
			schemas = {
				-- alacritty config
				['https://raw.githubusercontent.com/DmitryTravyan/alacritty/master/schema/reference.json'] = '/*',
				-- ansible config
				['https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/inventory.json'] = '/*',
				['https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks'] = '/*',
				['https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook'] = '/*',
			},
		},
	},
}
