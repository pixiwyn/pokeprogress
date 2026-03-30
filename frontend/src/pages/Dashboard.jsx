import { useEffect, useState, useRef } from 'react'
import { api } from '../api'
import Sidebar from '../components/Sidebar'
import PokemonDetail from '../components/PokemonDetail'

function Dashboard() {
  const dexLimit = 25

  const [games, setGames] = useState([])
  const [dex, setDex] = useState([])
  const [dexOffset, setDexOffset] = useState(0)
  const [selectedPokemon, setSelectedPokemon] = useState({})
  const loaderRef = useRef(null)

  useEffect(() => {
    async function loadGames() {
      const res = await api('/v1/games')
      console.log('games', res)
      setGames(res)
    }
    loadGames()
  }, [])

  useEffect(() => {
    async function getDex() {
      const res = await api(`/v1/pokedex?limit=${dexLimit}&offset=${dexOffset}`)
      setDex((prev) => {
        if (dexOffset === 0) setSelectedPokemon(res[0])
        return [...prev, ...res]
      })
    }
    getDex()
  }, [dexOffset])

  useEffect(() => {
    const observer = new IntersectionObserver((entries) => {
      if (entries[0].isIntersecting) {
        setDexOffset((prev) => prev + dexLimit)
      }
    })
    if (loaderRef.current) observer.observe(loaderRef.current)
    return () => observer.disconnect()
  }, [])

  return (
    <div className="flex-1 flex overflow-hidden">
      <Sidebar games={games} />
      <section className="w-1/2 border-r overflow-auto">
        <h2 className="px-4 pt-4 text-2xl text-white">Pokédex</h2>
        <p className="px-4 pt-4">GENERATION I - KANTO (? / 151)</p>
        <div className="grid grid-cols-[repeat(auto-fill,115px)] gap-4 justify-center p-4">
          {dex &&
            dex.map((pokemon, i) => (
              <div
                key={i}
                onClick={() => setSelectedPokemon(dex[i])}
                className={`w-[115px] h-fit  border rounded-md text-center hover:cursor-pointer hover:border-accent ${pokemon.id === selectedPokemon.id ? 'border-accent' : 'border-text-muted'}`}
              >
                <div className="p-4">
                  <img
                    src={pokemon.thumbnail}
                    className="bg-bg-highlight rounded-md"
                  />
                </div>

                <p>#{i + 1}</p>
                <p>{pokemon.name}</p>
              </div>
            ))}
          <div ref={loaderRef} />
        </div>
      </section>

      <PokemonDetail selectedPokemon={selectedPokemon} games={games} />
    </div>
  )
}

export default Dashboard
