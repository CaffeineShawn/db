
/**
 * @description 获取本地存储的一项数据
 * @param key 本地存储的key
 * @returns {string} 本地存储key键所对应的值
 * @description dsadsa
 */
export const getStorage = (key) => {
  const value =
    (localStorage.getItem(key) && JSON.parse(localStorage.getItem(key))) || ''
  return value
}
/**
 * @description 添加本地存储的一项数据
 * @param key 本地存储的key
 * @param data 本地存储的key键所对应的值
 * @returns
 */
export const setStorage = (key, data) => {
  return localStorage.setItem(key, JSON.stringify(data))
}

/**
 * @description 移除本地存储的一项数据
 * @param key 本地存储的key
 */
export const removeStorage = (key) => {
  return localStorage.removeItem(key)
}

export default {
  getStorage,
  setStorage,
  removeStorage
}
