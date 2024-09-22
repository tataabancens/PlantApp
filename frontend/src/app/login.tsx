import { Button } from "src/components/ui/button"
import { Input } from "src/components/ui/input"
import { Label } from "src/components/ui/label"
import React from 'react';

export default function Login() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-green-50">
      <div className="bg-white p-8 rounded-lg shadow-md w-96">
        <h1 className="text-3xl font-bold mb-6 text-center text-green-800">PlantApp</h1>
        <form className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="email" className="text-green-700">Correo electrónico</Label>
            <Input id="email" type="email" placeholder="tu@email.com" required className="border-green-300 focus:border-green-500 focus:ring-green-500" />
          </div>
          <div className="space-y-2">
            <Label htmlFor="password" className="text-green-700">Contraseña</Label>
            <Input id="password" type="password" required className="border-green-300 focus:border-green-500 focus:ring-green-500" />
          </div>
          <Button type="submit" className="w-full bg-green-600 hover:bg-green-700 text-white">
            Iniciar sesión
          </Button>
        </form>
        <div className="mt-4 text-center text-sm text-green-600">
          ¿No tienes una cuenta?{" "}
          <a href="/signup" className="underline hover:text-green-800">
            Regístrate
          </a>
        </div>
      </div>
    </div>
  )
}