import { useNavigate } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth'
import pokeball from '../assets/yellow_pokeball.svg'

function Header() {
  const { user, logout } = useAuth()
  const navigate = useNavigate()

  const handleLogout = () => {
    logout()
    navigate('/login')
  }

  return (
    <header className="p-4 border-b flex items-center justify-between">
      <h1 className="font-bold flex items-center gap-2">
        <img src={pokeball} alt="" className="h-[1em] w-[1em]" />
        PokéProgress
      </h1>
      {user && (
        <div>
          <a
            onClick={() => {}}
            className="text-xs text-text-muted hover:text-accent hover:cursor-pointer transition-color"
          >
            {user.user.username}
          </a>
          {' | '}
          <a
            onClick={handleLogout}
            className="text-xs text-text-muted hover:text-accent hover:cursor-pointer transition-colors"
          >
            SIGN OUT
          </a>
        </div>
      )}
    </header>
  )
}

export default Header
