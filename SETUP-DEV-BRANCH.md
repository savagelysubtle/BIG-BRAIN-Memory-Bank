# Setting Up The Development Branch Structure

Follow these manual steps to set up the dual-branch structure for the BIG BRAIN
Memory Bank:

## 1. Check your current branch

```
git branch
```

The current branch will be marked with an asterisk (\*).

## 2. If you're not on the memory-bank-dev branch:

### 2.1. Check if the branch already exists:

```
git branch
```

If `memory-bank-dev` is listed, switch to it:

```
git checkout memory-bank-dev
```

If not, create the branch:

```
git checkout -b memory-bank-dev
```

## 3. Push the development branch to GitHub

```
git push -u origin memory-bank-dev
```

## 4. Ensure your development files are committed

```
git add setup-dev-branch.bat DEVELOPMENT.md SETUP-DEV-BRANCH.md
git commit -S -m "Add development branch structure and documentation"
git push origin memory-bank-dev
```

## 5. Understanding your branch structure

You now have:

- **main branch**: The stable "clean install" version for new users
- **memory-bank-dev branch**: The development branch with all current
  improvements

## 6. Working with this structure

1. **For development work**:

   - Always stay on the `memory-bank-dev` branch
   - Use `git checkout memory-bank-dev` if you need to switch back

2. **For updating the stable version**:
   - When ready to update main with your improvements:
   ```
   git checkout main
   git pull origin main
   git merge --no-ff memory-bank-dev -m "Merge development into main: [DESCRIPTION]"
   git push origin main
   git checkout memory-bank-dev  # Return to development
   ```

## 7. Reminder

The DEVELOPMENT.md file contains more detailed information about the development
workflow and processes.
