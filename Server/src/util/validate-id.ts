export default async function requireEqual(userId: any, tokenUserId: string) {
  // eslint-disable-next-line @typescript-eslint/no-throw-literal
  if (userId !== tokenUserId) throw { message: 'user is not authorized to call this endpoint', name: 'UserUnauthorizedError' };
}
