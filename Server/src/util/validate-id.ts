/* eslint-disable max-len */
/**
 * @descirption requires the userId and the tokenUserId to be equal. tokenUserId should be the Id associated with the authorization token
 */
export const requireEqual = async (userId: any, tokenUserId: string) => {
  // eslint-disable-next-line @typescript-eslint/no-throw-literal
  if (userId !== tokenUserId) throw { message: 'user is not authorized to call this endpoint', name: 'UserUnauthorizedError' };
};

/**
 * @descirption requires either of the two userIds and the tokenUserId to be equal. tokenUserId should be the Id associated with the authorization token
 */
export const requireOneEqual = async (userId1: any, userId2: any, tokenUserId: string) => {
  // eslint-disable-next-line @typescript-eslint/no-throw-literal
  if (userId1 !== tokenUserId && userId2 !== tokenUserId) throw { message: 'user is not authorized to call this endpoint', name: 'UserUnauthorizedError' };
};
