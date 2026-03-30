const API_URL = import.meta.env.VITE_API_URL

export async function api(path, { body, ...options } = {}) {
  const user = localStorage.getItem('user')
    ? JSON.parse(localStorage.getItem('user'))
    : null

  const res = await fetch(`${API_URL}${path}`, {
    ...options,
    headers: {
      'Content-Type': 'application/json',
      ...(user && { Authorization: `Bearer ${user.token}` }),
      ...options.headers,
    },
    ...(body && { body: JSON.stringify(body) }),
  })

  if (res.status === 204) return null

  const data = await res.json()

  if (!res.ok) throw data

  return data
}
