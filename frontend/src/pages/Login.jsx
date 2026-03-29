import { useState } from 'react'
import { api } from '../api'
import Alert from '../components/Alert'
import { useAuth } from '../hooks/useAuth'
import { useNavigate } from 'react-router-dom'

function Login() {
  const [email, setEmail] = useState()
  const [password, setPassword] = useState()
  const [alertMessage, setAlertMessage] = useState(null)
  const { login } = useAuth()
  const navigate = useNavigate()

  return (
    <div className="grid md:grid-cols-2 md:gap-4 flex-1">
      <div className="flex flex-col  justify-center p-8 bg-bg-secondary md:border-r border-b md:border-b-0">
        <div className="text-xs mb-4">◈ Cross-game Pokédex tracker</div>
        <div className="font-bold text-2xl text-white">Track every catch.</div>
        <div className="font-bold text-2xl text-accent mb-4">
          Across every game.
        </div>
        <p className="mb-8">
          One place to track your catches, shinies, and milestones across every
          Pokémon game you play.
        </p>
        <ul className="list-disc list-inside text-sm flex flex-col gap-2">
          <li>Multi-game catch and shiny tracking</li>
          <li>Per-species milestones across every title</li>
          <li>Your own notes, your own pace</li>
          <li>Completion stats by generation</li>
        </ul>
      </div>
      <div className="flex items-center justify-center p-8">
        <div className="w-full max-w-sm">
          <h2 className="text-2xl font-bold text-white mb-1">Welcome back</h2>
          <p className="text-sm mb-8">// sign in to continue your run</p>
          <form className="flex flex-col gap-4">
            <Alert message={alertMessage} />
            <div className="flex flex-col gap-1">
              <label htmlFor="email" className="text-xs tracking-widest">
                EMAIL
              </label>
              <input
                name="email"
                type="text"
                onChange={(e) => setEmail(e.target.value)}
                className="bg-bg-primary border border-text-muted rounded px-3 py-2 text-white focus:outline-none focus:border-accent"
              />
            </div>
            <div className="flex flex-col gap-1">
              <label htmlFor="password" className="text-xs tracking-widest">
                PASSWORD
              </label>
              <input
                name="password"
                type="password"
                onChange={(e) => setPassword(e.target.value)}
                className="bg-bg-primary border border-text-muted rounded px-3 py-2 text-white focus:outline-none focus:border-accent"
              />
            </div>
            <div className="text-right">
              <a
                href="/forgot-password"
                className="text-xs text-accent hover:underline"
              >
                Forgot password?
              </a>
            </div>
            <button
              onClick={async (e) => {
                e.preventDefault()
                console.log('sign in', email, password)
                try {
                  const userData = await api('/v1/auth/login', {
                    method: 'POST',
                    body: { email, password },
                  })
                  login(userData)
                  navigate('/dashboard')
                } catch (e) {
                  console.log('error', e)
                  setAlertMessage('Invalid email or password')
                }
              }}
              className="bg-accent text-bg-primary font-bold py-2 rounded hover:opacity-90 transition-opacity"
            >
              SIGN IN
            </button>
            <p className="text-center text-sm">
              No account yet?{' '}
              <a href="/signup" className="text-accent hover:underline">
                Create one — it&apos;s free
              </a>
            </p>
          </form>
        </div>
      </div>
    </div>
  )
}

export default Login
