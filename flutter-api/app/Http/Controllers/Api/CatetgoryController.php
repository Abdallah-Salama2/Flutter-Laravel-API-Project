<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StroreCategoryRequest;
use App\Http\Resources\CategoryResource;
use App\Models\Category;
use Illuminate\Http\Request;

class CatetgoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        return CategoryResource::collection(Category::all());
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StroreCategoryRequest $request)
    {
        //
        $category=auth()->user()->categories()->create($request->validated());
        //return Category::create($request->validated());
        return new CategoryResource($category);
    }



    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        //
       // $category=Category::find
        //return $category;
        $category=Category::find($id);
        if(!$category){
            abort(404,'category not found');
        }
        return new  CategoryResource($category);

    }

    /**
     * Update the specified resource in storage.
     */
    public function update(StroreCategoryRequest $request, Category $category)
    {
        //
        $category->update($request->validated());
        return new CategoryResource($category);

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Category $category)
    {
        //
        $category->delete();
        return response()->noContent();
    }
}
