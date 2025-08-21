return {
	"nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
	event = "ColorScheme",
	config = function()
		require("lualine").setup({
			options = {
                section_separators = '',
                component_separators = '',
			},
            sections = {
                lualine_c = {
                    {
                        'filename',
                        path = 1
                    },
                    {
                        "navic",
                        navic_opts = {
                            highlight = true,
                        }
                    }
                },
                lualine_x = {'lsp_status', 'encoding', 'fileformat', 'filetype'},
            },
		})

        vim.api.nvim_set_hl(0, "NavicIconsFile",          {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsModule",        {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsNamespace",     {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsPackage",       {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsClass",         {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsMethod",        {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsProperty",      {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsField",         {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsConstructor",   {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsEnum",          {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsInterface",     {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsFunction",      {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsVariable",      {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsConstant",      {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsString",        {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsNumber",        {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsBoolean",       {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsArray",         {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsObject",        {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsKey",           {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsNull",          {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsEnumMember",    {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsStruct",        {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsEvent",         {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsOperator",      {default = true})
        vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", {default = true})
        vim.api.nvim_set_hl(0, "NavicText",               {default = true})
        vim.api.nvim_set_hl(0, "NavicSeparator",          {default = true})
	end
}
