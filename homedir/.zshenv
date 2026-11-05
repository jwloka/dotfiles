fpath=($fpath $HOME/.zsh/func)
typeset -U fpath

# Plot: Bitbucket-Login für «Only my work» auf dem Board (Bitbucket nennt ihn ohne API-Anfrage nicht).
# In .zshenv statt .zshrc, damit auch nicht-interaktive Shells ihn kennen (Board, Skripte).
export PLOT_BUDGET_ACCOUNT=jwloka
