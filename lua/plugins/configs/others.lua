local M = {}
local utils = require "core.utils"

M.blankline = {
  indentLine_enabled = 1,
  filetype_exclude = {
    "help",
    "terminal",
    "lazy",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "mason",
    "nvdash",
    "nvcheatsheet",
    "",
  },
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  show_current_context = true,
  show_current_context_start = true,
}

M.luasnip = function(opts)
    local ls = require ('luasnip')
  ls.config.set_config(opts)

  -- vscode format
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

  -- snipmate format
  require("luasnip.loaders.from_snipmate").load()
  require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

  -- lua format
  require("luasnip.loaders.from_lua").load()
  require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.add_snippets('typescriptreact', {
  -- Basic HTML tags
  s('div', { t('<div>'), i(1), t('</div>') }),
  s('div.class', { t('<div className="'), i(1), t('">'), i(2), t('</div>') }),
  s('div.id', { t('<div id="'), i(1), t('">'), i(2), t('</div>') }),
  s('span', { t('<span>'), i(1), t('</span>') }),
  s('span.class', { t('<span className="'), i(1), t('">'), i(2), t('</span>') }),
  s('span.id', { t('<span id="'), i(1), t('">'), i(2), t('</span>') }),
  s('p', { t('<p>'), i(1), t('</p>') }),
  s('p.class', { t('<p className="'), i(1), t('">'), i(2), t('</p>') }),
  s('p.id', { t('<p id="'), i(1), t('">'), i(2), t('</p>') }),
  s('h1', { t('<h1>'), i(1), t('</h1>') }),
  s('h1.class', { t('<h1 className="'), i(1), t('">'), i(2), t('</h1>') }),
  s('h1.id', { t('<h1 id="'), i(1), t('">'), i(2), t('</h1>') }),
  s('h2', { t('<h2>'), i(1), t('</h2>') }),
  s('h2.class', { t('<h2 className="'), i(1), t('">'), i(2), t('</h2>') }),
  s('h2.id', { t('<h2 id="'), i(1), t('">'), i(2), t('</h2>') }),
  s('h3', { t('<h3>'), i(1), t('</h3>') }),
  s('h3.class', { t('<h3 className="'), i(1), t('">'), i(2), t('</h3>') }),
  s('h3.id', { t('<h3 id="'), i(1), t('">'), i(2), t('</h3>') }),
  s('h4', { t('<h4>'), i(1), t('</h4>') }),
  s('h4.class', { t('<h4 className="'), i(1), t('">'), i(2), t('</h4>') }),
  s('h4.id', { t('<h4 id="'), i(1), t('">'), i(2), t('</h4>') }),
  s('h5', { t('<h5>'), i(1), t('</h5>') }),
  s('h5.class', { t('<h5 className="'), i(1), t('">'), i(2), t('</h5>') }),
  s('h5.id', { t('<h5 id="'), i(1), t('">'), i(2), t('</h5>') }),
  s('h6', { t('<h6>'), i(1), t('</h6>') }),
  s('h6.class', { t('<h6 className="'), i(1), t('">'), i(2), t('</h6>') }),
  s('h6.id', { t('<h6 id="'), i(1), t('">'), i(2), t('</h6>') }),
  s('a', { t('<a href="'), i(1), t('">'), i(2), t('</a>') }),
  s('a.class', { t('<a className="'), i(1), t('" href="'), i(2), t('">'), i(3), t('</a>') }),
  s('a.id', { t('<a id="'), i(1), t('" href="'), i(2), t('">'), i(3), t('</a>') }),
  s('img', { t('<img src="'), i(1), t('" alt="'), i(2), t('"/>') }),
  s('img.class', { t('<img className="'), i(1), t('" src="'), i(2), t('" alt="'), i(3), t('"/>') }),
  s('img.id', { t('<img id="'), i(1), t('" src="'), i(2), t('" alt="'), i(3), t('"/>') }),
  s('ul', { t('<ul>'), t({'', '  '}), i(1), t({'', '</ul>'}) }),
  s('ul.class', { t('<ul className="'), i(1), t('">'), t({'', '  '}), i(2), t({'', '</ul>'}) }),
  s('ul.id', { t('<ul id="'), i(1), t('">'), t({'', '  '}), i(2), t({'', '</ul>'}) }),
  s('ol', { t('<ol>'), t({'', '  '}), i(1), t({'', '</ol>'}) }),
  s('ol.class', { t('<ol className="'), i(1), t('">'), t({'', '  '}), i(2), t({'', '</ol>'}) }),
  s('ol.id', { t('<ol id="'), i(1), t('">'), t({'', '  '}), i(2), t({'', '</ol>'}) }),
  s('li', { t('<li>'), i(1), t('</li>') }),
  s('li.class', { t('<li className="'), i(1), t('">'), i(2), t('</li>') }),
  s('li.id', { t('<li id="'), i(1), t('">'), i(2), t('</li>') }),
  s('button', { t('<button>'), i(1), t('</button>') }),
  s('button.class', { t('<button className="'), i(1), t('">'), i(2), t('</button>') }),
  s('button.id', { t('<button id="'), i(1), t('">'), i(2), t('</button>') }),
  s('input', { t('<input type="'), i(1, 'text'), t('" name="'), i(2), t('" value="'), i(3), t('"/>') }),
  s('input.class', { t('<input className="'), i(1), t('" type="'), i(2, 'text'), t('" name="'), i(3), t('" value="'), i(4), t('"/>') }),
  s('input.id', { t('<input id="'), i(1), t('" type="'), i(2, 'text'), t('" name="'), i(3), t('" value="'), i(4), t('"/>') }),
  s('form', { t('<form action="'), i(1), t('" method="'), i(2, 'post'), t('">'), t({'', '  '}), i(3), t({'', '</form>'}) }),
  s('form.class', { t('<form className="'), i(1), t('" action="'), i(2), t('" method="'), i(3, 'post'), t('">'), t({'', '  '}), i(4), t({'', '</form>'}) }),
  s('form.id', { t('<form id="'), i(1), t('" action="'), i(2), t('" method="'), i(3, 'post'), t('">'), t({'', '  '}), i(4), t({'', '</form>'}) }),
  s('textarea', { t('<textarea name="'), i(1), t('">'), i(2), t('</textarea>') }),
  s('textarea.class', { t('<textarea className="'), i(1), t('" name="'), i(2), t('">'), i(3), t('</textarea>') }),
  s('textarea.id', { t('<textarea id="'), i(1), t('" name="'), i(2), t('">'), i(3), t('</textarea>') }),
  s('label', { t('<label for="'), i(1), t('">'), i(2), t('</label>') }),
  s('label.class', { t('<label className="'), i(1), t('" for="'), i(2), t('">'), i(3), t('</label>') }),
  s('label.id', { t('<label id="'), i(1), t('" for="'), i(2), t('">'), i(3), t('</label>') }),
  s('select', { t('<select name="'), i(1), t('">'), t({'', '  '}), i(2), t({'', '</select>'}) }),
  s('select.class', { t('<select className="'), i(1), t('" name="'), i(2), t('">'), t({'', '  '}), i(3), t({'', '</select>'}) }),
  s('select.id', { t('<select id="'), i(1), t('" name="'), i(2), t('">'), t({'', '  '}), i(3), t({'', '</select>'}) }),
  s('option', { t('<option value="'), i(1), t('">'), i(2), t('</option>') }),
  s('option.class', { t('<option className="'), i(1), t('" value="'), i(2), t('">'), i(3), t('</option>') }),
  s('option.id', { t('<option id="'), i(1), t('" value="'), i(2), t('">'), i(3), t('</option>') }),
  -- Additional tags
  s('header', { t('<header>'), i(1), t('</header>') }),
  s('header.class', { t('<header className="'), i(1), t('">'), i(2), t('</header>') }),
  s('header.id', { t('<header id="'), i(1), t('">'), i(2), t('</header>') }),
  s('footer', { t('<footer>'), i(1), t('</footer>') }),
  s('footer.class', { t('<footer className="'), i(1), t('">'), i(2), t('</footer>') }),
  s('footer.id', { t('<footer id="'), i(1), t('">'), i(2), t('</footer>') }),
  s('section', { t('<section>'), i(1), t('</section>') }),
  s('section.class', { t('<section className="'), i(1), t('">'), i(2), t('</section>') }),
  s('section.id', { t('<section id="'), i(1), t('">'), i(2), t('</section>') }),
  s('article', { t('<article>'), i(1), t('</article>') }),
  s('article.class', { t('<article className="'), i(1), t('">'), i(2), t('</article>') }),
  s('article.id', { t('<article id="'), i(1), t('">'), i(2), t('</article>') }),
  s('aside', { t('<aside>'), i(1), t('</aside>') }),
  s('aside.class', { t('<aside className="'), i(1), t('">'), i(2), t('</aside>') }),
  s('aside.id', { t('<aside id="'), i(1), t('">'), i(2), t('</aside>') }),
  s('nav', { t('<nav>'), i(1), t('</nav>') }),
  s('nav.class', { t('<nav className="'), i(1), t('">'), i(2), t('</nav>') }),
  s('nav.id', { t('<nav id="'), i(1), t('">'), i(2), t('</nav>') }),
  s('main', { t('<main>'), i(1), t('</main>') }),
  s('main.class', { t('<main className="'), i(1), t('">'), i(2), t('</main>') }),
  s('main.id', { t('<main id="'), i(1), t('">'), i(2), t('</main>') }),})
  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      if
        require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })
end

return M
