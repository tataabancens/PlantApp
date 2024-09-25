import { clsx, ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"
 
export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

export const apiPath = "https://21bakowg31.execute-api.us-east-1.amazonaws.com"
export const plantsPath = `${apiPath}/plants`
export const placeHolderImagePath = 'data:image/png;base64,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'

// const plantData = [
  // { 
  //   id: 1, 
  //   name: "Ficus", 
  //   image: "/placeholder.svg?height=100&width=100", 
  //   wateringFrequency: 7, 

  //   lastWatered: new Date(2023, 5, 15),
  //   wateringHistory: [
  //     new Date(2023, 5, 15),
  //     new Date(2023, 5, 8),
  //     new Date(2023, 5, 1),
  //     new Date(2023, 4, 24),
  //   ]
  // },
//   { 
//     id: 2, 
//     name: "Cactus", 
//     image: "/placeholder.svg?height=100&width=100", 
//     wateringFrequency: 14, 
//     lastWatered: new Date(2023, 5, 10),
//     wateringHistory: [
//       new Date(2023, 5, 10),
//       new Date(2023, 4, 27),
//       new Date(2023, 4, 13),
//     ]
//   },
//   { 
//     id: 3, 
//     name: "Orquídea", 
//     image: "/placeholder.svg?height=100&width=100", 
//     wateringFrequency: 3, 
//     lastWatered: new Date(2023, 5, 14),
//     wateringHistory: [
//       new Date(2023, 5, 14),
//       new Date(2023, 5, 11),
//       new Date(2023, 5, 8),
//       new Date(2023, 5, 5),
//       new Date(2023, 5, 2),
//     ]
//   },
// ]