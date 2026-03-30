import { useEffect, useState } from 'react'
import { api } from '../api'

function Sidebar(games) {
  console.log('sidebar - games', games)
  return (
    <nav className="flex flex-col w-1/5 border-r sidebar text-xs">
      <p className="mt-4 pt-4 pl-2">MY GAMES</p>

      <div className="m-2 p-2 bg-bg-highlight border border-text-muted rounded-md flex items-center justify-between">
        <div>
          <span className="text-red-500">●</span>{' '}
          <span className="font-bold text-white">Fire Red</span>
        </div>

        <span className="text-red-500">0%</span>
      </div>
      <button className="m-2 p-2 border border-dashed border-text-muted rounded-md hover:cursor-pointer hover:border-accent">
        + Add Game
      </button>

      <p className="mt-4 pl-2">VIEW</p>
      <a className="p-2 w-full bg-bg-highlight border-l-2 border-accent">
        ◈ Pokédex
      </a>
      <a className="p-2 w-full ">⊙ By Location</a>
      <a className="p-2 w-full ">◎ By Generation</a>
      <p className="mt-4 pl-2">FILTER</p>

      <a className="p-2 w-full ">○ Not Caught</a>
      <a className="p-2 w-full ">● Caught</a>
      <a className="p-2 w-full ">◑ Partial</a>
    </nav>
  )
}

export default Sidebar
