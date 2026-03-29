function Alert({ message, type = 'error' }) {
  if (!message) return null

  const styles = {
    error: 'border-red-500 text-red-400',
    success: 'border-accent text-accent',
  }

  return (
    <div className={`border rounded px-3 py-2 text-sm ${styles[type]}`}>
      {message}
    </div>
  )
}

export default Alert
