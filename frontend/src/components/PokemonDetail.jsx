import { useEffect, useRef, useState } from 'react'
import { api } from '../api'

function PokemonDetail({ selectedPokemon, games }) {
  const debounceRef = useRef(null)
  const [note, setNote] = useState('')
  const [progress, setProgress] = useState([])

  async function logGameProgress({ game_id, metadata }) {
    setProgress((prev) => {
      const existing = prev.find((p) => p.game_id === game_id)
      if (existing) {
        return prev.map((p) => (p.game_id === game_id ? { ...p, metadata } : p))
      }
      return [...prev, { game_id, metadata }]
    })
    await api('/v1/progress', {
      method: 'POST',
      body: {
        pokemon_id: selectedPokemon.id,
        game_id,
        metadata,
      },
    })
  }

  async function saveNote(note) {
    clearTimeout(debounceRef.current)
    debounceRef.current = setTimeout(async () => {
      await api('/v1/notes', {
        method: 'POST',
        body: { pokemon_id: selectedPokemon.id, note },
      })
      console.log('note saved')
    }, 500)
    setNote((prev) => note)
  }

  useEffect(() => {
    async function getNote() {
      const res = await api(`/v1/notes/${selectedPokemon.id}`)
      setNote(res?.note || '')
    }

    async function getGameProgress() {
      const res = await api(`/v1/progress?pokemon_id=${selectedPokemon.id}`)
      console.log('game progress', res)
      setProgress(res || [])
    }

    getNote()
    getGameProgress()
  }, [selectedPokemon])

  return (
    <article className="w-[30%] px-4">
      <div className="w-[135px] h-fit text-center">
        <div className="p-4">
          <img
            src={selectedPokemon.thumbnail}
            className="bg-bg-highlight rounded-md"
          />
        </div>
      </div>
      <h3 className="text-2xl text-white">{selectedPokemon.name}</h3>
      <p>#{selectedPokemon.id}</p>
      <h4 className="pt-4">PROGRESS BY GAME</h4>
      {games &&
        games.map((game) => (
          <div className="p-2 bg-bg-highlight border-text-muted border rounded-md flex">
            <span className="px-2" style={{ color: game.color }}>
              {game.short_name}
            </span>
            <div className="pl-4">
              <input
                name="caught"
                checked={
                  progress.find((p) => p.game_id === game.id)?.metadata
                    ?.caught === true
                }
                onChange={(e) => {
                  logGameProgress({
                    game_id: game.id,
                    metadata: { caught: e.target.checked },
                  })
                }}
                type="checkbox"
              />{' '}
              <label htmlFor="caught" className="text-sm">
                Caught
              </label>
            </div>
          </div>
        ))}

      <h4 className="pt-4">WHERE TO FIND</h4>
      <h4 className="pt-4">YOUR NOTES</h4>
      <textarea
        value={note}
        rows="6"
        onChange={(e) => saveNote(e.target.value)}
        className="w-full border border-text-muted rounded"
      ></textarea>
    </article>
  )
}

export default PokemonDetail
