module.exports = {
  target: (name) => {
    if (name === 'eslint') return 'minor';
    if (name === '@types/node') return 'minor';
    if (name === '@heroui/react') return 'minor';
    return 'latest';
  },
};
