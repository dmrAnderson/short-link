Link.create(
  full_name: 'https://github.com/',
  short_name: SecureRandom.alphanumeric(5),
  password: SecureRandom.hex(2)
)

Link.create(
  full_name: 'https://www.google.com.ua/?hl=ru',
  short_name: SecureRandom.alphanumeric(5),
  password: SecureRandom.hex(2)
)

Link.create(
  full_name: 'https://www.youtube.com/?hl=uk&gl=UA',
  short_name: SecureRandom.alphanumeric(5),
  password: SecureRandom.hex(2)
)
